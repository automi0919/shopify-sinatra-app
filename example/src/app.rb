require 'sinatra/shopify-sinatra-app'
require 'sinatra/flash'

class SinatraApp < Sinatra::Base
  register Sinatra::Shopify
  register Sinatra::Flash

  # Configure via ENV so you can change without code deploy
  set :scope, ENV.fetch('SHOPIFY_SCOPE', 'read_products, read_orders')

  # Home page: fetch shop + top 10 products
  get '/' do
    shopify_session do |_shop_name|
      @shop = ShopifyAPI::Shop.current
      @products = ShopifyAPI::Product.find(:all, params: { limit: 10 })
      erb :home
    end
  rescue ActiveResource::ResourceNotFound, ActiveResource::ClientError => e
    flash[:error] = "Shopify API error: #{e.message}"
    erb :home
  end

  # Uninstall webhook: clean up persisted shop data
  shopify_webhook '/uninstall' do |shop_name, _payload|
    Shop.find_by(name: shop_name)&.destroy
  end

  private

  # Runs after successful install/auth.
  # Best practice: register uninstall webhook automatically.
  def after_shopify_auth
    shopify_session do |_shop_name|
      webhook = ShopifyAPI::Webhook.new(
        topic: 'app/uninstalled',
        address: "#{base_url}/uninstall",
        format: 'json'
      )

      begin
        webhook.save!
      rescue => e
        # If webhook already exists, Shopify may respond with an error
        # and the record may still be persisted. Only raise if not persisted.
        raise e unless webhook.persisted?
      end
    end
  end
end

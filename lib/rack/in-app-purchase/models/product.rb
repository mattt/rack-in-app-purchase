# frozen_string_literal: true

module Rack
  class InAppPurchase
    class Product < Sequel::Model
      TYPES = ['Consumable', 'Non-Consumable', 'Free Subscription', 'Auto-Renewable Subscription', 'Non-Renewable Subscription'].freeze

      plugin :json_serializer, naked: true, except: :id
      plugin :validation_helpers
      plugin :timestamps, force: true, update_on_create: true

      self.dataset = :in_app_purchase_products
      self.strict_param_setting = false
      self.raise_on_save_failure = false

      def validate
        super

        validates_presence %i[product_identifier title description price price_locale]
        validates_numeric :price
        validates_includes TYPES, :type
      end
    end
  end
end

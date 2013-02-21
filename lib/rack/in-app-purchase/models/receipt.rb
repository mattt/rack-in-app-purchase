module Rack
  class InAppPurchase
    DB = Sequel.connect(ENV['DATABASE_URL'] || "postgres://localhost:5432/in_app_purchase_example")
    Sequel::Migrator.run(DB, ::File.join(::File.dirname(__FILE__), "../migrations"))

    class Receipt < Sequel::Model
      plugin :json_serializer, naked: true, except: :id 
      plugin :validation_helpers
      plugin :timestamps, force: true
      
      self.dataset = :in_app_purchase_receipts
      self.strict_param_setting = false
      self.raise_on_save_failure = false

      def validate
        super
      
        validates_presence [:product_id, :transaction_id, :purchase_date]
        validates_unique :transaction_id
      end
    end
  end
end

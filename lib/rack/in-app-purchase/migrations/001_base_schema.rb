# frozen_string_literal: true

Sequel.migration do
  up do
    create_table :in_app_purchase_products do
      primary_key :id

      column :product_identifier,           :varchar,   null: false
      column :type,                         :varchar,   null: false
      column :title,                        :varchar,   null: false
      column :description,                  :varchar
      column :price,                        :float8
      column :price_locale,                 :varchar
      column :is_enabled,                   :boolean, default: true

      index :product_identifier
      index :type
    end

    create_table :in_app_purchase_receipts do
      primary_key :id

      column :quantity,                     :int4
      column :product_id,                   :varchar,   null: false
      column :transaction_id,               :varchar,   null: false
      column :purchase_date,                :timestamp, null: false
      column :original_transaction_id,      :varchar
      column :original_purchase_date,       :timestamp
      column :app_item_id,                  :varchar
      column :version_external_identifier,  :varchar
      column :bid,                          :varchar
      column :bvrs,                         :varchar
      column :ip_address,                   :inet
      column :created_at,                   :timestamp

      index :product_id
      index :transaction_id
      index :app_item_id
    end
  end

  down do
    drop_table :in_app_purchase_products
    drop_table :in_app_purchase_receipts
  end
end

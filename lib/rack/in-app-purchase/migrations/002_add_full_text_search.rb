Sequel.migration do
  up do
    add_column :in_app_purchase_products, :tsv, 'TSVector'
    add_index :in_app_purchase_products, :tsv, type: "GIN"
    create_trigger :in_app_purchase_products, :tsv, :tsvector_update_trigger, 
      args: [:tsv, :'pg_catalog.english', :product_identifier, :type, :title, :description], 
      events: [:insert, :update], 
      each_row: true

    add_column :in_app_purchase_receipts, :tsv, 'TSVector'
    add_index :in_app_purchase_receipts, :tsv, type: "GIN"
    create_trigger :in_app_purchase_receipts, :tsv, :tsvector_update_trigger, 
      args: [:tsv, :'pg_catalog.english', :product_id, :transaction_id, :app_item_id], 
      events: [:insert, :update], 
      each_row: true
  end

  down do
    drop_column :in_app_purchase_products, :tsv
    drop_index :in_app_purchase_products, :tsv
    drop_trigger :in_app_purchase_products, :tsv

    drop_column :in_app_purchase_receipts, :tsv
    drop_index :in_app_purchase_receipts, :tsv
    drop_trigger :in_app_purchase_receipts, :tsv
  end
end

FactoryBot.define do
  factory :food do
    imported_t { Time.now }
    status { 'draft' }
    url { 'https://example.com/product' }
    creator { 'John Doe' }
    created_t { Time.now }
    last_modified_t { Time.now }
    product_name { 'Product Name' }
    quantity { '380 g (6 x 2 u.)' }
    brands { 'Brand Name' }
    categories { 'Category 1, Category 2' }
    labels { 'Label 1, Label 2' }
    cities { 'City 1, City 2' }
    purchase_places { 'Purchase Place 1, Purchase Place 2' }
    stores { 'Store 1, Store 2' }
    ingredients_text { 'Ingredients text goes here' }
    traces { 'Traces information' }
    serving_size { 'serving size info' }
    serving_quantity { 31.7 }
    nutriscore_score { 17 }
    nutriscore_grade { 'd' }
    main_category { 'Main Category' }
    image_url { 'https://example.com/image.jpg' }
  end
end

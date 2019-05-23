# DB設計
## users table
- メルカリ利用ユーザ情報、クレジットカード情報を登録する。

|column_physical|column_logic|type|null|options|remarks|
|---------------|------------|----|----|-------|-------|
|nickname|ニックネーム|string|false|||
|email|メールアドレス|string|false|unique: true||
|password|パスワード|string|false|||
|last_name|姓|string|false|||
|first_name|名|string|false|||
|last_name_phonetic|姓(カナ)|string|false|||
|first_name_phonetic|名(カナ)|string|false|||
|icon_image|アイコン画像|string|true|||
|profile|プロフィール|text|true|||
|birth|生年月日|string|false|||
|tel|電話番号|string|false|||
### index
- primary key
### Association
- has_many :todos
- has_many :points
- has_many :bank_accounts
- has_many :news
- has_many :comments
- has_many :evaluations, through: :user_evaluation
- has_many :products, through: :likes
- has_one :user_address
- has_one :shipping_address
- has_one :credit_card

## user_address table
- メルカリ利用ユーザの住所情報を登録する。

|column_physical|column_logic|type|null|options|remarks|
|---------------|------------|----|----|-------|-------|
|user_id|ユーザID|reference|false|foreign_key: true||
|post_code|郵便番号|string|false|||
|prefectures|都道府県|string|false|||
|city|市町村|string|false|||
|address_number|番地|string|false|||
|building_name|ビル名|string|false|||
### index
- primary key
### Association
- belongs_to :user

## shipping_address table
- メルカリ利用ユーザの配送先情報を登録する。

|column_physical|column_logic|type|null|options|remarks|
|---------------|------------|----|----|-------|-------|
|user_id|ユーザID|reference|false|foreign_key: true||
|delivery_post_code|届け先郵便番号|string|false|||
|delivery_prefectures|届け先都道府県|string|false|||
|delivery_city|届け先市町村|string|false|||
|delivery_address_number|届け先番地|string|false|||
|delivery_building_name|届け先ビル名|string|true|||
### index
- primary key
### Association
- belongs_to :user

## credit_cards table
- メルカリ利用ユーザのクレジットカード情報を登録する。

|column_physical|column_logic|type|null|options|remarks|
|---------------|------------|----|----|-------|-------|
|user_id|ユーザID|reference|false|foreign_key: true||
|card_number|カード番号|string|false|||
|expiration_year|有効期限(年)|string|false|||
|expiration_month|有効期限(月)|string|false|||
|security_code|セキュリティコード|string|false|||
|created_at|登録日時|datetime|false|||
|updated_at|更新日時|datetime|false|||
### index
- primary key
### Association
- belongs_to :user

## bank_accounts table
- ユーザの口座情報を登録する。

|column_physical|column_logic|type|null|options|remarks|
|---------------|------------|----|----|-------|-------|
|user_id|ユーザID|reference|false|foreign_key: true||
|name|銀行名|string|false|||
|account_type|口座種別|string|false|||
|branch_code|支店コード|string|false|||
|account_number|口座番号|string|false|unique: true||
|last_name_phonetic|口座名義(セイ)|string|false|||
|first_name_phonetic|口座名義(メイ)|string|false|||
|created_at|登録日時|datetime|false|||
|updated_at|更新日時|datetime|false|||
### index
- user_id
### Association
- belongs_to :user

## points table
- ユーザの所有ポイントを管理する。

|column_physical|column_logic|type|null|options|remarks|
|---------------|------------|----|----|-------|-------|
|user_id|ユーザID|reference|false|foreign_key: true||
|point|ポイント|integer|false|default:0||
|details|詳細|text|false|||
|expiration_date|有効期限|string|false|||
|created_at|登録日時|datetime|false|||
|updated_at|更新日時|datetime|false|||
### index
- user_id
### Association
- belongs_to :user

## evaluations table
- 評価値を登録する。

|column_physical|column_logic|type|null|options|remarks|
|---------------|------------|----|----|-------|-------|
|evaluation|評価|string|false||value:良い,普通,悪い|
|created_at|登録日時|datetime|false|||
|updated_at|更新日時|datetime|false|||
### index
- primary key
### Association
- has_many :users, through: :user_evaluation

## user_evaluation table
- ユーザ毎の評価を管理する。

|column_physical|column_logic|type|null|options|remarks|
|---------------|------------|----|----|-------|-------|
|user_id|(評価された)ユーザID|reference|false|foreign_key: true||
|evaluator_id|(評価した)ユーザID|reference|false|foreign_key: true||
|evaluation_id|評価ID|reference|false|foreign_key: true||
|created_at|登録日時|datetime|false|||
|updated_at|更新日時|datetime|false|||
### index
- user_id
### Association
- belongs_to :user
- belongs_to :evaluation

## products table
- 出品商品を登録する。出品ステータスによって、出品/購入を管理し、履歴としても利用する。

|column_physical|column_logic|type|null|options|remarks|
|---------------|------------|----|----|-------|-------|
|seller_id|ユーザID(出品者)|reference|false|foreign_key: true||
|buyer_id|ユーザID(購入者)|reference|true|foreign_key: true||
|category_id|カテゴリID|reference|false|foreign_key: true||
|purchase_date|購入日|string|true|||
|name|商品名|string|false|||
|explanation|商品説明|string|false|||
|price|値段|integer|false|||
|brand|ブランド|string|true|||
|delivery_fee_owner|配送料負担者|string|false|||
|shipping_source_area|配送先エリア|string|false|||
|shipping_days|発送日数|string|false|||
|delivery_method|配送方法|string|false|||
|exhibition_status|出品ステータス|string|false|||
|product_status|商品ステータス|string|false|||
|size|サイズ|string|true|||
|like|いいね数|integer|false|default:0||
|created_at|登録日時|datetime|false|||
|updated_at|更新日時|datetime|false|||
### index
- primary key
- seller_id, eshibition_status
### Association
- belongs_to :category
- has_many :product_images
- has_many :comments
- has_many :users, through: :likes

## product_images table
- 商品画像を登録する。１商品１０枚まで。

|column_physical|column_logic|type|null|options|remarks|
|---------------|------------|----|----|-------|-------|
|product_id|商品ID|reference|false|foreign_key: true||
|image_url|商品画像|string|false|||
|created_at|登録日時|datetime|false|||
|updated_at|更新日時|datetime|false|||
### index
- product_id
### Association
- belongs_to :product

## comments table
- 商品へのコメントを登録する。

|column_physical|column_logic|type|null|options|remarks|
|---------------|------------|----|----|-------|-------|
|product_id|商品ID|reference|false|foreign_key: true||
|user_id|(コメントした)ユーザID|reference|false|foreign_key: true||
|comment|コメント|text|false|||
|created_at|登録日時|datetime|false|||
|updated_at|更新日時|datetime|false|||
### index
- product_id, user_id
### Association
- belongs_to :product
- belongs_to :user

## categories table
- 商品カテゴリを登録する。gemのancestryを使用予定。

|column_physical|column_logic|type|null|options|remarks|
|---------------|------------|----|----|-------|-------|
|name|カテゴリ名|string|false|||
|ancestry|階層(子要素/孫要素)|string|true|||
|created_at|登録日時|datetime|false|||
|updated_at|更新日時|datetime|false|||
### index
- primary key
### Association
- has_many :brands, through: :category_brand
- has_many :sizes, through: :category_size
- has_ancestry

## brands table
- 各ブランド名を管理する。出品商品登録時のブランド入力欄のインクリメンタルサーチで使用予定。

|column_physical|column_logic|type|null|options|remarks|
|---------------|------------|----|----|-------|-------|
|name|ブランド名|string|false|||
|created_at|登録日時|datetime|false|||
|updated_at|更新日時|datetime|false|||
### index
- primary key
### Association
- has_many :categories, through: :category_brand

## sizes table
- カテゴリに対する各サイズを管理する。レディース、メンズ、キッズの衣類・靴など計６種類。

|column_physical|column_logic|type|null|options|remarks|
|---------------|------------|----|----|-------|-------|
|size|サイズ|string|false|||
|created_at|登録日時|datetime|false|||
|updated_at|更新日時|datetime|false|||
### index
- primary key
### Association
- has_many :categories, through: :category_size

## category_brand table
- 各カテゴリ毎のブランドを管理する。

|column_physical|column_logic|type|null|options|remarks|
|---------------|------------|----|----|-------|-------|
|category_id|カテゴリID|reference|false|foreign_key: true||
|brand_id|ブランドID|reference|false|||
|created_at|登録日時|datetime|false|||
|updated_at|更新日時|datetime|false|||
### index
- category_id, brand_id
### Association
- belongs_to :category
- belongs_to :brand

## category_size table
- 各カテゴリの孫要素に紐付くサイズを登録する。

|column_physical|column_logic|type|null|options|remarks|
|---------------|------------|----|----|-------|-------|
|category_id|カテゴリID|reference|false|foreign_key: true||
|size_id|サイズID|reference|false|||
|created_at|登録日時|datetime|false|||
|updated_at|更新日時|datetime|false|||
### index
- category_id, size_id
### Association
- belongs_to :category
- belongs_to :size

## likes table
- 商品に対してのいいねを登録する。集計も当テーブルを利用予定。

|column_physical|column_logic|type|null|options|remarks|
|---------------|------------|----|----|-------|-------|
|product_id|商品ID|reference|false|foreign_key: true||
|user_id|(いいねした)ユーザID|reference|false|foreign_key: true||
|created_at|登録日時|datetime|false|||
|updated_at|更新日時|datetime|false|||
### index
- product_id, user_id
### Association
- belongs_to :user
- belongs_to :product

## todos table
- ユーザのやることリストを管理する。

|column_physical|column_logic|type|null|options|remarks|
|---------------|------------|----|----|-------|-------|
|user_id|ユーザID|reference|false|foreign_key: true||
|todo|やること|text|false|||
|created_at|登録日時|datetime|false|||
|updated_at|更新日時|datetime|false|||
### index
- user_id
### Association
- belongs_to :user

## news table
- ニュース一覧および個別のお知らせを管理する。

|column_physical|column_logic|type|null|options|remarks|
|---------------|------------|----|----|-------|-------|
|user_id|ユーザID|reference|true|foreign_key: true||
|page_url|ページURL|string|false|||
|message_type|メッセージタイプ|string|false||1:all, 2:individual|
|created_at|登録日時|datetime|false|||
|updated_at|更新日時|datetime|false|||
### index
- user_id, message_type
### Association
- belongs_to :user

## product_status table
- 商品の状態を登録する。出品商品画面のセレクトボックスで利用予定。

|column_physical|column_logic|type|null|options|remarks|
|---------------|------------|----|----|-------|-------|
|status|商品ステータス|string|false||values:新品、未使用,未使用に近い,目立った傷や汚れなし,やや傷や汚れあり,傷や汚れあり,全体的に状態が悪い|
|created_at|登録日時|datetime|false|||
|updated_at|更新日時|datetime|false|||
### index
- primary key

## delivery_fee_owners table
- 配送料金負担者を登録する。出品商品画面のセレクトボックスで利用予定。

|column_physical|column_logic|type|null|options|remarks|
|---------------|------------|----|----|-------|-------|
|delivery_fee_owner|配送料負担者|string|false||values:送料込み(出品者負担),着払い(購入者負担)|
|created_at|登録日時|datetime|false|||
|updated_at|更新日時|datetime|false|||
### index
- primary key

## delivery_methods table
- 配送方法を登録する。出品商品画面のセレクトボックスで利用予定。

|column_physical|column_logic|type|null|options|remarks|
|---------------|------------|----|----|-------|-------|
|delivery_method|配送方法|string|false||values:未定,らくらくメリカリ便,ゆうメール,レターパック,普通郵便(定形、定形外),クロネコヤマト,ゆうパック,クリックポスト,ゆうパケット|
|created_at|登録日時|datetime|false|||
|updated_at|更新日時|datetime|false|||
### index
- primary key

## shipping_days table
- 発送日を登録する。出品商品画面のセレクトボックスで利用予定。

|column_physical|column_logic|type|null|options|remarks|
|---------------|------------|----|----|-------|-------|
|shipping_days|発送日数|string|false||values:1〜2日で発送,2〜3日で発送,4〜7日で発送|
|created_at|登録日時|datetime|false|||
|updated_at|更新日時|datetime|false|||
### index
- primary key

## banks table
- 銀行名を登録する。出品商品画面のセレクトボックス、インクリメンタルサーチで利用予定。

|column_physical|column_logic|type|null|options|remarks|
|---------------|------------|----|----|-------|-------|
|name|銀行名|string|false||values:三菱UFJ銀行,みずほ銀行,りそな銀行,埼玉りそな銀行,三井住友銀行,ジャパンネット銀行,楽天銀行,ゆうちょ銀行|
|inc_flag|インクリメンタルサーチフラグ|boolean|false|||
|created_at|登録日時|datetime|false|||
|updated_at|更新日時|datetime|false|||
### index
- primary key

## bank_account_types table
- 口座種別を登録する。出品商品画面のセレクトボックスで利用予定。

|column_physical|column_logic|type|null|options|remarks|
|---------------|------------|----|----|-------|-------|
|account_type|口座種別|string|false||values:普通預金,当座預金,貯蓄預金|
|created_at|登録日時|datetime|false|||
|updated_at|更新日時|datetime|false|||
### index
- primary key

# HACHI APP


[![Image from Gyazo](https://i.gyazo.com/2f889cba5ab3b9b10089038bd15f956b.gif)](https://gyazo.com/2f889cba5ab3b9b10089038bd15f956b)

## About／概要

絵を描くことが好きな姉のためのアプリ<br>
自分の作品を投稿し、他人からコメントをもらえます。
<br>

### 実装機能
- ユーザー管理機能
- 作品新規投稿機能
- 作品詳細表示機能
- 作品編集/削除機能
- 作品検索機能
- コメント投稿機能

#### 作品新規投稿機能

[![Image from Gyazo](https://i.gyazo.com/221f9bf81e3d3a94afc1ea51837f9b69.gif)](https://gyazo.com/221f9bf81e3d3a94afc1ea51837f9b69)
<br>

#### 作品詳細表示機能

[![Image from Gyazo](https://i.gyazo.com/24234592a1dca468f3c6021ed10cfbf5.gif)](https://gyazo.com/24234592a1dca468f3c6021ed10cfbf5)
<br>

#### コメント投稿機能

[![Image from Gyazo](https://i.gyazo.com/baaa0d0949f6468f98e4f7f23ad4fad8.gif)](https://gyazo.com/baaa0d0949f6468f98e4f7f23ad4fad8)
<br>


## Description／説明

作成のきっかけ
- 絵が趣味である姉の作品を趣味レベルで終わらせず、もっと多くの人に見てもらいたいという思った
- 姉の「自分の絵でなにか仕事ができないか」という発言から、仕事につなげる手助けがしたいと思った
<br>


## 本番環境(デプロイ先　テストアカウント＆ID)

[デプロイ先](https://hachi-app.herokuapp.com/)
<br><br>
テストアカウント1<br>
EMAIL：test1@test<br>
PASS：123456<br>
<br>
テストアカウント2<br>
EMAIL：test2@test<br>
PASS：123456<br>
<br>

紫色のボタンからログインできます
<br>
[![Image from Gyazo](https://i.gyazo.com/478f2245830b5caf322ecbc3c2153655.png)](https://gyazo.com/478f2245830b5caf322ecbc3c2153655)
<br>


## Features／工夫点

- アプリ内の主役はあくまでも作品（画像）なので、文字を小さく・文字色を薄めにするなど、シンプルな見た目になるよう心がけました。
<br>

## Dependency／開発技術

- Ruby
- Ruby on Rails
- devise
- GitHub
- AWS/S3
<br>

## Future features／実装予定の機能

- [ ] タグ付け機能
- [ ] いいね機能
- [ ] 1対1のチャット機能
- [ ] 動画投稿機能
<br>


## DB設計


## usersテーブル
| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| nickname | string | null: false |

### association
- has_many :works
- has_many :comments



## worksテーブル
| Column      | Type       | Options                            |
| ----------- | ---------- | ---------------------------------- |
| title       | string     | null: false                        |
| description | text       | null: false                        |
| user_id     | references | null: false, foreign_key: true     |

### association
- belongs_to :user
- has_many :comments
- has_many :work_tags
- has_many :tags, through: :work_tags



## tagsテーブル
| Column | Type   | Options     |
| ------ | ------ | ----------- |
| name   | string | null: false |

### association
- has_many :work_tags
- has_many :tags, through: :work_tags



## work_tagsテーブル
| Column  | Type       | Options     |
| ------- | ---------- | ----------- |
| work_id | references | null: false |
| tag_id  | references | null: false |

### association
- belongs_to :work
- belongs_to :tag



## commentsテーブル
| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| comment | text       | null: false                    |
| user_id | references | null: false, foreign_key: true |
| work_id | references | null: false, foreign_key: true |

### association
- belongs_to :user
- belongs_to :work

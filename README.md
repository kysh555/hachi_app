・本番環境(デプロイ先　テストアカウント＆ID)
・制作背景(意図)
　⇒どんな課題や不便なことを解決するためにこのアプリを作ったのか。
・DEMO(gifで動画や写真を貼って、ビューのイメージを掴んでもらいます)
　⇒特に、デプロイがまだできていない場合はDEMOをつけることで見た目を企業側に伝えることができます。
・工夫したポイント


# HACHI APP

You can access from [here](https://hachi-app.herokuapp.com/).<br>


## About／概要

絵を描くことが好きな姉のためのアプリ


## Description／説明

絵を描く趣味を持つ姉が、


## Demo


## Features／工夫点

- アプリ内の主役は作品（画像）なので、文字を小さく・文字色を薄めにするなど、シンプルな見た目になるよう心がけました。
- 匿名性を与えないために、ログインユーザーのみが作品・コメントを投稿できるようしました。


## Dependency／開発技術

- Ruby
- Ruby on Rails
- devise
- GitHub
- AWS/S3


## Future features／実装予定の機能

- [ ] タグ付け機能
- [ ] いいね機能
- [ ] 1対1のチャット機能

- - -
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

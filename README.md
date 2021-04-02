# HACHI APP


## About／概要

絵を描くことが好きな姉のためのアプリ<br>
自分の作品を投稿し、他人からコメントをもらえます。
<br>


## Description／説明

作成のきっかけ
- 絵が趣味である姉の作品を、趣味レベルで終わらせずに、もっと多くの人に見てもらいたいと思った
- 姉が「自分の絵で副業を始めたい」と言っていたので、仕事につなげる手助けがしたいと思った

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


## Features／工夫点

- アプリ内の主役は作品（画像）なので、文字を小さく・文字色を薄めにするなど、シンプルな見た目になるよう心がけました。
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

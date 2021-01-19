## usersテーブル
| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| nickname | string | null: false |

### association
- has_many :works
- has_many :comments



## worksテーブル
| Column      | Type   | Options                            |
| ----------- | ------ | ---------------------------------- |
| name        | string | null: false                        |
| description | string | null: false                        |
| user_id     | references | null: false, foreign_key: true |

### association
- belongs_to :user
- has_many :comments



### commentsテーブル
| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| comment | text       | null: false                    |
| user_id | references | null: false, foreign_key: true |
| work_id | references | null: false, foreign_key: true |

## association
- belongs_to :user
- belongs_to :works

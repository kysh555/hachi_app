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
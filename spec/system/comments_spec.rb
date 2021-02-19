require 'rails_helper'

RSpec.describe "コメント投稿", type: :system do
  before do
    @work = FactoryBot.create(:work)
    @comment = Faker::Lorem.sentence
  end

  it 'ログインしているユーザーは作品詳細ページでコメントを投稿できる' do
    # ログインする
    sign_in(@work.user)
    # 作品の画像が詳細ページ遷移するボタンであることを確認する
    expect(page).to have_link href: work_path(@work)
    # 詳細ページへ移動する
    visit work_path(@work)
    # コメント投稿フォームが存在することを確認する
    expect(page).to have_selector 'form'
    # 作品詳細ページに移動する
    visit work_path(@work)
    # フォームに情報を入力する
    fill_in 'comment_text', with: @comment
    # 送信するとCommentモデルのカウントが1上がる
    expect{
      find('input[name="commit"]').click
    }.to change { Comment.count }.by(1)
    # 詳細ページに戻される
    expect(current_path).to eq(work_path(@work))
    # 詳細ページに送信したコメント内容が含まれていることを確認する
    expect(page).to have_content @comment
  end
end

require 'rails_helper'

RSpec.describe '作品投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @work = FactoryBot.create(:work)
  end

  context '新規投稿ができるとき' do
    it 'ログインしているユーザーは新規投稿ができる' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email',    with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # トップページに移動する
      visit root_path
      # トップページに新規投稿ページへ遷移するボタンが存在する
      expect(page).to have_content('new post')
      # 新規投稿ページに移動する
      visit new_work_path
      # フォームに必要な情報を入力する
      image_path = Rails.root.join('public/images/test_image.png')
      attach_file('work[images][]', image_path, make_visible: true)
      fill_in 'work_title',  with: @work.title
      fill_in 'work_description', with: @work.description
      # 送信するとWorkモデルのカウントが1上がる
      expect{
        find('input[name="commit"]').click
      }.to change { Work.count }.by(1)
      # 投稿完了ページに遷移する
      expect(current_path).to eq(works_path)
      # ページに「投稿が完了しました」の文字が表示される
      expect(page).to have_content('投稿が完了しました')
      # トップページに移動する
      visit root_path
      # トップページに投稿内容が存在する（画像）
      expect(page).to have_selector('img')
      # トップページに投稿内容が存在する（タイトル）
      expect(page).to have_content(@work.title)
    end
  end

  context '新規投稿ができないとき' do
    it 'ログアウト状態のユーザーは新規投稿できない' do
      # トップページに移動する
      visit root_path
      # トップページに新規投稿ページへ遷移するボタンが存在しない
      expect(page).to have_no_content('new post')
    end
  end
end

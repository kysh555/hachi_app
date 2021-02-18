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
      expect(page).to have_selector("img[src$='test_image.png']")
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

RSpec.describe '作品編集', type: :system do
  before do
    @work1 = FactoryBot.create(:work)
    @work2 = FactoryBot.create(:work)
  end

  context '作品編集ができるとき' do
    it 'ログインしているユーザーは自分が投稿したツイートの編集ができる' do
      # work1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Email',    with: @work1.user.email
      fill_in 'Password', with: @work1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # work1の画像が詳細ページへ遷移するボタンであることを確認する
      expect(page).to have_link href: work_path(@work1)
      # 詳細ページにへ移動する
      visit work_path(@work1)
      # work1の詳細ページに編集ボタンがあることを確認する
      expect(page).to have_content('編集する')
      # 編集ページへ遷移する
      visit edit_work_path(@work1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#work_title').value
      ).to eq(@work1.title)
      expect(
        find('#work_description').value
      ).to eq(@work1.description)
      # 投稿内容を編集する
      fill_in 'work_title',       with: "#{@work1.title}+あ"
      fill_in 'work_description', with: "#{@work1.description}+あ"
      # 編集してもWorkモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Work.count }.by(0)
      # 編集完了画面に遷移したことを確認する
      expect(current_path).to eq(work_path(@work1))
      # 「更新しました」の文字があることを確認する
      expect(page).to have_content('更新しました')
      # トップページに遷移する
      visit root_path
      # トップページには先ほど変更した内容の作品が存在することを確認する（画像）
      expect(page).to have_selector("img[src$='test_image.png']")
      # トップページには先ほど変更した内容の作品が存在することを確認する（タイトル）
      expect(page).to have_content("#{@work1.title}+あ")
    end
  end
  context '作品編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した作品の編集画面には遷移できない' do
      # work1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Email',    with: @work1.user.email
      fill_in 'Password', with: @work1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # work2の画像が詳細ページへ遷移するボタンであることを確認する
      expect(page).to have_link href: work_path(@work2)
      # 詳細ページに移動する
      visit work_path(@work2)
      # work2に「編集」ボタンがないことを確認する
      expect(page).to have_no_link '編集する', href: edit_work_path(@work2)
    end
    it 'ログインしていないと作品の編集画面には遷移できない' do
      # トップページに移動する
      visit root_path
      # work1の画像が詳細ページへ遷移するボタンであることを確認する
      expect(page).to have_link href: work_path(@work1)
      # 詳細ページにへ移動する
      visit work_path(@work1)
      # work1に「編集」ボタンがないことを確認する
      expect(page).to have_no_link '編集する', href: edit_work_path(@work1)
      # トップページに移動する
      visit root_path
      # work2の画像が詳細ページへ遷移するボタンであることを確認する
      expect(page).to have_link href: work_path(@work2)
      # 詳細ページに移動する
      visit work_path(@work2)
      # work2に「編集」ボタンがないことを確認する
      expect(page).to have_no_link '編集する', href: edit_work_path(@work2)
    end
  end
end

RSpec.describe '作品削除', type: :system do
  before do
    @work1 = FactoryBot.create(:work)
    @work2 = FactoryBot.create(:work)
  end

  context '作品削除ができるとき' do
    it 'ログインしているユーザーは自分が投稿した作品の削除ができる' do
      # work1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Email',    with: @work1.user.email
      fill_in 'Password', with: @work1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # work1の画像が詳細ページへ遷移するボタンであることを確認する
      expect(page).to have_link href: work_path(@work1)
      # 詳細ページにへ移動する
      visit work_path(@work1)
      # work1に「削除」ボタンがあることを確認する
      expect(page).to have_link '削除する', href: work_path(@work1)
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect{
        find_link('削除する', href: work_path(@work1)).click
      }.to change { Work.count }.by(-1)
      # 削除完了画面に遷移したことを確認する
      expect(current_path).to eq(work_path(@work1))
      # 「削除が完了しました」の文字があることを確認する
      expect(page).to have_content('削除が完了しました')
      # トップページに遷移する
      visit root_path
      # トップページにはwork1の内容が存在しないことを確認する（画像）
      expect(page).to have_no_selector(".img")
      # トップページにはwork1の内容が存在しないことを確認する（タイトル）
      expect(page).to have_no_content("#{@work1.title}")
    end
  end

  context '作品削除ができないとき' do
    it 'ログインしているユーザーは自分以外の人が投稿した作品の削除はできない' do
      # work1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Email',    with: @work1.user.email
      fill_in 'Password', with: @work1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # work2の画像が詳細ページへ遷移するボタンであることを確認する
      expect(page).to have_link href: work_path(@work2)
      # 詳細ページに移動する
      visit work_path(@work2)
      # ツイート2に「削除」ボタンが無いことを確認する
      expect(page).to have_no_link '削除する', href: work_path(@work2)
    end
    it 'ログインしていないと作品の削除ボタンが表示されない' do
      # トップページに移動する
      visit root_path
      # work1の画像が詳細ページへ遷移するボタンであることを確認する
      expect(page).to have_link href: work_path(@work1)
      # 詳細ページにへ移動する
      visit work_path(@work1)
      # work1に「削除」ボタンがないことを確認する
      expect(page).to have_no_link '削除する', href: work_path(@work1)
      # トップページに移動する
      visit root_path
      # work2の画像が詳細ページへ遷移するボタンであることを確認する
      expect(page).to have_link href: work_path(@work2)
      # 詳細ページに移動する
      visit work_path(@work2)
      # work2に「削除」ボタンがないことを確認する
      expect(page).to have_no_link '削除する', href: work_path(@work2)
    end
  end
end
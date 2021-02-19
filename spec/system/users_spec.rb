require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すれば新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # トップページに新規登録ページへ遷移するボタンが存在する
      expect(page).to have_content('sign up')
      # 新規登録ページに移動する
      visit new_user_registration_path
      # 登録に必要な情報を入力する
      fill_in 'Nickname', with: @user.nickname
      fill_in 'Email',    with: @user.email
      fill_in 'Password', with: @user.password
      fill_in 'Password confirmation', with: @user.password_confirmation
      # サインアップボタンを押すとユーザーモデルのカウントが1上がる
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページに移動する
      expect(current_path).to eq(root_path)
      # トップページに新規登録ページへ遷移するボタンが存在しない
      expect(page).to have_no_content('sign up')
    end
  end

  context 'ユーザー新規登録ができないとき' do
    it '誤った情報を入力すると新規登録ができずに新規登録ページに戻る' do
      # トップページに移動する
      visit root_path
      # トップページに新規登録ページへ遷移するボタンが存在する
      expect(page).to have_content('sign up')
      # 新規登録ページに移動する
      visit new_user_registration_path
      # 登録に必要な情報を入力する
      fill_in 'Nickname', with: ''
      fill_in 'Email',    with: ''
      fill_in 'Password', with: ''
      fill_in 'Password confirmation', with: ''
      # サインアップボタンを押してもユーザーモデルのカウントが上がらない
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページに戻される
      expect(current_path).to eq(user_registration_path)
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログインできるとき' do
    it '正しい情報を入力すればログインできる' do
      # トップページに移動する
      visit root_path
      # トップページにログインページに遷移するボタンが存在する
      expect(page).to have_content('sign in')
      # ログインページに移動する
      visit new_user_session_path
      # ログインに必要な情報を入力する
      fill_in 'Email',    with: @user.email
      fill_in 'Password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移する
      expect(current_path).to eq(root_path)
      # トップページにログアウトボタンとマイページボタンが存在する
      expect(page).to have_content('sign out')
      expect(page).to have_content('my page')
      # トップページにサインアップボタンが存在しない
      expect(page).to have_no_content('sign up')
    end
  end

  context 'ログインできないとき' do
    it '保存されているユーザー情報を一致しない情報を入力するとログインできずにログインページに戻る' do
      # トップページに移動する
      visit root_path
      # トップページにログインページに遷移するボタンが存在する
      expect(page).to have_content('sign in')
      # ログインページに移動する
      visit new_user_session_path
      # 誤った情報を入力する
      fill_in 'Email',    with: ''
      fill_in 'Password', with: ''
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページに戻される
      expect(current_path).to eq(user_session_path)
    end
  end
end
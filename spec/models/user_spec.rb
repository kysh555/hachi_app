require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー登録機能' do
    before do
      @user = FactoryBot.build(:user)
    end

    context '新規登録がうまくいく時' do
      it 'nickname・email・password・password_confirmationが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'nicknameが3文字以上だと登録できる' do
        @user.nickname = 'aaa'
        expect(@user).to be_valid
      end
      it 'nicknameが8文字以下だと登録できる' do
        @user.nickname = 'aaaaaaaa'
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上だと登録できる' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかない時' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'nicknameが1文字では登録できない' do
        @user.nickname = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname is too short (minimum is 2 characters)")
      end
      it 'nicknameが9文字以上では登録できない' do
        @user.nickname = 'aaaaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname is too long (maximum is 8 characters)")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailが存在すると登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'passwordが存在してもpassword_confirmationが存在しないと登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー登録機能' do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'nickname・email・password・password_confirmationが存在すれば登録できる' do
    end

    it 'nicknameが空では登録できない' do
    end
    it 'nicknameが2文字以下では登録できない' do
    end
    it 'nicknameが8文字以上では登録できない' do
    end
    it 'emailが空では登録できない' do
    end
    it '重複したemailが存在すると登録できない' do
    end
    it 'passwordが空では登録できない' do
    end
    it 'passwordが5文字以下では登録できない' do
    end
    it 'passwordが存在してもpassword_confirmationが存在しないと登録できない' do
    end
  end
end

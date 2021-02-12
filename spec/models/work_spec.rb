require 'rails_helper'

RSpec.describe Work, type: :model do
  before do
    @work = FactoryBot.build(:work)
  end

  describe '投稿の保存' do
    context '投稿の保存ができるとき' do
      it 'title・description・画像があれば保存できる' do
        expect(@work).to be_valid
      end
    end

    context '投稿の保存ができないとき' do
      it 'titleが空では保存できない' do
        @work.title = ''
        @work.valid?
        expect(@work.errors.full_messages).to include("Title can't be blank")
      end
      it 'descriptionが空では保存できない' do
        @work.description = ''
        @work.valid?
        expect(@work.errors.full_messages).to include("Description can't be blank")
      end
      it 'imagesが空では保存できない' do
        @work.images = nil
        @work.valid?
        expect(@work.errors.full_messages).to include("Images can't be blank")
      end
      it 'ユーザーが紐づいていないと登録できない' do
        @work.user = nil
        @work.valid?
        expect(@work.errors.full_messages).to include("User must exist")
      end
    end
  end
end

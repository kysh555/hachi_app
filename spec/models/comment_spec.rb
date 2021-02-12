require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe '投稿したコメントの保存' do
    context 'コメントが保存できるとき' do
      it 'textがあれば保存できる' do
        expect(@comment).to be_valid
      end
    end

    context 'コメントが保存できないとき' do
      it 'textが空では保存できない' do
        @comment.text = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Text can't be blank")
      end
      it 'userが紐づいていないと保存できない' do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("User must exist")
      end
      it 'workが紐づいていないと保存できない' do
        @comment.work = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Work must exist")
      end
    end
  end
end

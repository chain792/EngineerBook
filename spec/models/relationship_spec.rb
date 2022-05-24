require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'バリデーション確認' do
    let(:created_relationship) { create(:relationship) }

    it '有効であること' do
      relationship = build(:relationship)
      expect(relationship).to be_valid
      expect(relationship.errors).to be_empty
    end

    it '重複している組み合わせの場合、無効' do
      relationship = build(:relationship, follower: created_relationship.follower, followed: created_relationship.followed)
      expect(relationship).to be_invalid
      expect(relationship.errors[:follower_id]).to eq ["はすでに存在します"]
    end
  end
end

require 'spec_helper'

describe News do
  let(:bob) {build :user}
  let(:public_project) {build :public_project}
  let(:news) {build :news, :project => public_project, :author => bob}

  it {should validate_presence_of :title}
  it {should validate_presence_of :description}
  it {should ensure_length_of(:title).is_at_most(60)}
  it {should ensure_length_of(:summary).is_at_most(255)}
  
  it {should belong_to :project}
  it {should belong_to :author}
  it {should have_many :comments}
  
  describe ".latest" do
    subject {News.latest}
    
    context "when there is one project with the news module active with a news" do
      before {news.save}
      
      it {should include news}
    end
    
    context "when there is one project with the news module not active with a news" do
      let(:inactive_news_project) {build :public_project, :enabled_module_names => []}
      let(:news_in_inactive_news_project) {build :news, :project => inactive_news_project, :author => bob}
      
      before {news_in_inactive_news_project.save}
      
      it {should_not include news_in_inactive_news_project}
    end
    
    context "when there is one private project with a news" do
      let(:private_project) {build :private_project}
      let(:news_in_private_project) {build :news, :project => private_project, :author => bob}
      
      before {news_in_private_project.save}
      
      it {should_not include news_in_private_project}
    end
    
    context "when there is a project with 10 news" do
      before {create_list :news, 10, :project => public_project, :author => bob}
      
      its(:size) {should eql 5}
      
      it "should return 6 news if asked to do so" do
        News.latest(User.current, 6).size.should eql 6
      end
      
      it "should return 2 news if asked to do so" do
        News.latest(User.current, 2).size.should eql 2
      end
    end
  end
  
  it "should send an email notification on creation"
end

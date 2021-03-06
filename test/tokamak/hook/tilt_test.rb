require 'test/unit'
require 'rubygems'
require "methodize"
require "tilt"

begin
  require 'ruby-debug'
rescue Exception => e; end

require "tokamak/hook/tilt"

class Tokamak::Hook::TiltTest < Test::Unit::TestCase
  def setup
    @template_file = File.expand_path(File.dirname(__FILE__) + '/../../rails2_skel/app/views/test/show.tokamak')
  end
  
  def test_tokamak_builder_with_tilt_and_unsupported_media_type
    e = assert_raise(Tokamak::BuilderError) do
      template = Tokamak::Hook::Tilt::TokamakTemplate.new(@template_file, :media_type => 'unsupported/type')
      template.render(self)
    end
    assert_equal "Could not find a builder for the media type: unsupported/type", e.message
  end

  def test_tokamak_builder_integration_with_tilt
    @some_articles = [
      {:id => 1, :title => "a great article", :updated => Time.now},
      {:id => 2, :title => "another great article", :updated => Time.now}
    ]

    template = Tokamak::Hook::Tilt::TokamakTemplate.new(@template_file, :media_type => "application/json")
    json     = template.render(self, :@some_articles => @some_articles)
    hash     = JSON.parse(json).extend(Methodize)

    assert_equal "John Doe"               , hash.author.first.name
    assert_equal "foobar@example.com"     , hash.author.last.email
    assert_equal "http://example.com/json", hash.id

    assert_equal "http://a.link.com/next" , hash.links.first.href
    assert_equal "next"                   , hash.links.first.rel

    assert_equal "uri:1"                      , hash.articles.first.id
    assert_equal "a great article"            , hash.articles.first.title
    assert_equal "http://example.com/image/1" , hash.articles.last.links.first.href
    assert_equal "image"                      , hash.articles.last.links.first.rel
    assert_equal "application/json"           , hash.articles.last.links.last.type
  end
end

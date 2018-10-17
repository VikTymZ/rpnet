xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0",
'xmlns:content' => "http://purl.org/rss/1.0/modules/content/",
'xmlns:wfw' => "http://wellformedweb.org/CommentAPI/",
'xmlns:dc' => "http://purl.org/dc/elements/1.1/",
'xmlns:atom' => "http://www.w3.org/2005/Atom",
'xmlns:sy' => "http://purl.org/rss/1.0/modules/syndication/",
'xmlns:slash' => "http://purl.org/rss/1.0/modules/slash/" do
  xml.channel do
    xml.title "Rizkie Pratama Blog"
    xml.description "Rizkie Pratama Personal Blog"
    xml.language 'id'
    xml.tag! 'atom:link', :rel => 'self', :type => 'application/rss+xml', :href => blog_feed_url

    @posts.each do |post|
      xml.item do
        xml.title post.title
        xml.link "#{request.base_url}/blog/#{post.slug}"
        xml.guid "#{request.base_url}/blog/#{post.slug}"
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.content(:encode) { xml.cdata!(post.content) }
      end
    end
  end
end

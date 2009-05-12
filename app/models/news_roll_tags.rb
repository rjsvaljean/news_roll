module NewsRollTags
  include Radiant::Taggable

  tag 'items' do |tag|
    tag.expand
  end

  tag 'items:each' do |tag|
    result = []
    Item.find(:all, :limit => 4, :order => 'created_at DESC').each do |item|
      tag.locals.item = item
      result << tag.expand
    end
    result
  end

  tag 'items:each:item' do |tag|
    item = tag.locals.item
    req = tag.globals.page.request

    if req.language.split('-').first == 'de'
      %{
        <span class="headline">#{item.de_headline} : </span>
        <span class="leadtext">#{item.de_leadtext}</span> 
        <a href="/news/show/#{item.id}">[mehr]</a>
      }
    else
      %{
        <span class="headline">#{item.en_headline} : </span>
        <span class="leadtext">#{item.en_leadtext}</span> [more]
      }
    end
  end

end

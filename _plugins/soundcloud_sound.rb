#  SoundCloud embed tag for Jekyll/Liquid
#
#  Usage: 
#  
#    {% soundcloud_sound 12345 %}
#    {% soundcloud_sound 12345 widgetname %}
#    {% soundcloud_sound 12345 widgetname ffffff %}
#    {% soundcloud_sound 12345 widgetname ffffff small %}
#
#    ... where 12345 is the SoundCloud sound ID, widgetname is the sound's visual 
#    representation, ffffff is the color, and size is, well, the size (SoundCloud gives you 
#    three options for the "artwork" widget).
#
#  Available SoundCloud widgets:
#   
#    html5 (default)
#    flash *
#    mini *
#    artwork *
#    
#    * Requires a paid SoundCloud tier
#
#  Author: Chris Nunciato (@cnunciato)
#  Source: http://github.com/cnunciato/jekyll-soundcloud

require 'shellwords'

module Jekyll
  class SoundCloudSoundTag < Liquid::Tag

    def initialize(tag_name, markup, tokens)
      super
      params = Shellwords.shellwords markup
      @sound = { :id => params[0], :widget => params[1] || "html5", :color => params[2] || "ff7700", :size => params[3] || "medium" }
    end

    def render(context)
      "<iframe width=\"100%\" height=\"20\" scrolling=\"no\" frameborder=\"no\" src=\"https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/#{@sound[:id]}&amp;color=616f7c&amp;inverse=true&amp;auto_play=false&amp;show_user=true\"></iframe>"
    end

    private

      def dimension(size)
        case @sound[:size]

        when 'small'
          220
        when 'medium'
          300
        when 'large'
          425
        else
          0
        end
      end

  end

end

Liquid::Template.register_tag('soundcloud_sound', Jekyll::SoundCloudSoundTag)
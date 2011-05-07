# Helper methods defined here can be accessed in any controller or view in the application

AboutUs.helpers do
  def page_nums!
    actual_pages = all_pages.map{|page| Integer(page) }
    params[:page] ||= ("%02d" % 0)
    params[:page_num] = num = Integer(params[:page])
    params[:next_num] = (num + 1 <= actual_pages.max ? num + 1 : nil )
    params[:prev_num] = (num - 1 > 0 ? num - 1 : 0 )
  end
  def all_pages
    haml_view_paths = Dir.glob('app/views/pages/*.haml').map {|path| path[0..-6]} 
    pages = haml_view_paths.collect do |haml_path|
      static_view_path = File.basename(haml_path)
      if(static_view_path == 'cover')
        '00'
      elsif(static_view_path == 'navigation')
        nil
      else
        static_view_path
      end
    end
    pages.compact
  end
  # Output the awesome conditional HTML IE sniffer in haml
  def conditional_html( lang = "en", &block )
    haml_concat <<-"HTML".gsub( /^\s+/, '' )
      <!--[if lt IE 7 ]>              <html lang="#{lang}" class="no-js ie6"> <![endif]-->
      <!--[if IE 7 ]>                 <html lang="#{lang}" class="no-js ie7"> <![endif]-->
      <!--[if IE 8 ]>                 <html lang="#{lang}" class="no-js ie8"> <![endif]-->
      <!--[if IE 9 ]>                 <html lang="#{lang}" class="no-js ie9"> <![endif]-->
      <!--[if (gte IE 9)|!(IE)]><!--> <html lang="#{lang}" class="no-js"> <!--<![endif]-->      
    HTML
    haml_concat capture( &block ) << "\n</html>"  if block_given?
  end

  # Output a script tag pointing to jquery, with fallback to local
  # /javascripts/libs/jquery.js
  def jquery_with_fallback(options={})
    options = {:version => "1.5.1"}.merge(options)
    str = ""
    str += "<script src=\"//ajax.googleapis.com/ajax/libs/jquery/#{options['jquery_version']}/jquery.js\"></script>"
    url = '/javascripts/libs/jquery.js'
    str += "\n<script>window.jQuery || document.write(\"<script src='#{url}'>\\x3C/script>\")</script>"
  end
  
  
  # def simple_helper_method
  #  ...
  # end
end

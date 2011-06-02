# Helper methods defined here can be accessed in any controller or view in the application

BakersOven.helpers do
  # def simple_helper_method
  #  ...
  # end
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
  
  def prep_pages(page)
    @page = page
    current_book = @page.book
    @current_book = @page.book
    @pages = @page.book.pages.all(:order => :page_number)
    page_num = @pages.index(@page)
    @prev_page = @pages[page_num - 1] if page_num > 0
    @next_page = @pages[page_num + 1] if page_num < (@pages.size - 1)
    @cover_page = @pages.first
  end
  # 
end

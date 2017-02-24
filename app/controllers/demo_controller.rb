class DemoController < ApplicationController
  layout "application"	

  def index
  	# render(:template => 'demo/index')
  	render('index') # shortcut
  end

  def hello  
  	# render('index')
  	@array = [12, 645, 423, 989, 0, -2]	
  	@id = params['id'].to_i
  	@page = params[:page].to_i
  end

  def other_hello
  	redirect_to(:controller => 'demo', :action => 'index')
  end

  def other_site
  	redirect_to('http://www.google.com.br')
  end

  def text_helpers    
  end

  def escape_output    
  end

  def make_error
  # 3 most common errors:
  # render(:text => "test" # syntax error
  # render(:text => @something.upcase) # undefined method
  # render(:text => "1" + 1) # can't convert type    
  end

  def logging
    logger.debug("This is a debug message.")
    logger.info("This is a info message.")
    logger.warn("This is a warn message.")
    logger.error("This is a error message.")
    logger.fatal("This is a fatal message.")
    render(:text => "Logged!")
  end

end

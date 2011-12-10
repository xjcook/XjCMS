# -*- encoding : utf-8 -*-
module ApplicationHelper
  def flash_messages
    f_names = [:notice, :warning, :message]
    fl = ''
  
    for name in f_names
      if flash[name]
        fl = fl + "<div class=\"notice\">#{flash[name]}</div>"
      end
      flash[name] = nil;
    end
    return fl
  end
end

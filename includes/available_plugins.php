<?php

//to include menus from plugins
  $app_plugin_menu = array();
  
//include available plugins  
  if(defined('AVAILABLE_PLUGINS'))
  {
    foreach(explode(',',AVAILABLE_PLUGINS) as $plugin)
    {            
      //include language file   
      if(isset($app_user))
      {         
        if(is_file($v = 'plugins/' . $plugin .'/languages/' . $app_user['language'] ))
        {          
          require($v);
        }
        elseif(is_file($v = 'plugins/' . $plugin .'/languages/' . CFG_APP_LANGUAGE ))
        {
          require($v);
        }
      }
      
      //include plugin
      if(is_file('plugins/' . $plugin .'/application_top.php'))
      {
        require('plugins/' . $plugin .'/application_top.php');
      }
      
      //include menu if not ajax query
      if(is_file('plugins/' . $plugin .'/menu.php') and !IS_AJAX)
      {
        require('plugins/' . $plugin .'/menu.php');
      }
    }
  } 
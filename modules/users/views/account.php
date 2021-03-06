<h3 class="page-title"><?php echo TEXT_HEADING_MY_ACCOUNT ?></h3>

<div class="portlet">
  <div class="portlet-title">
  	<div class="caption">
  		<i class="fa fa-reorder"></i><?php echo TEXT_DETAILS ?>
  	</div>
  </div>
  <div class="portlet-body form">


<?php echo form_tag('account_form', url_for('users/account','action=update'),array('enctype'=>'multipart/form-data','class'=>'form-horizontal')) ?>
  <div class="form-body">

<?php
  $count_tabs = db_count('app_forms_tabs',$current_entity_id,"entities_id");
  
  $html = '';
  
  if($count_tabs>1)
  {
    $count = 0;
    $html = '<ul class="nav nav-tabs" id="form_tabs">';
    $tabs_query = db_fetch_all('app_forms_tabs',"entities_id='" . db_input($current_entity_id) . "' order by  sort_order, name");
    while($tabs = db_fetch_array($tabs_query))
    {
      $html .= '<li ' . ($count==0 ? 'class="active"':'') . '><a href="#form_tab_' . $tabs['id'] . '">' . $tabs['name'] . '</a></li>';
      $count++;
    }
    $html .= '</ul>';
    
    
    $html .= '<div class="tab-content">';
    $count = 0;
    
    $tabs_query = db_fetch_all('app_forms_tabs',"entities_id='" . db_input($current_entity_id) . "' order by  sort_order, name");
    while($tabs = db_fetch_array($tabs_query))
    {
              
      $html .= '
        <div class="tab-pane ' . ($count==0 ? 'active':'') . '" id="form_tab_' . $tabs['id'] . '">
          <table class="form_table">';
      
      $fields_query = db_query("select f.*, t.name as tab_name from app_fields f, app_forms_tabs t where f.type not in (" . fields_types::get_reserverd_types_list(). ",'fieldtype_user_accessgroups','fieldtype_user_status','fieldtype_user_skin') and  f.entities_id='" . db_input($current_entity_id) . "' and f.forms_tabs_id=t.id and f.forms_tabs_id='" . db_input($tabs['id']) . "' order by t.sort_order, t.name, f.sort_order, f.name");
      while($v = db_fetch_array($fields_query))
      {
        $html .='
          <tr>
            <td>' . tooltip_icon($v['tooltip']) . '</td>
            <td><label for="fields_' . $v['id']  . '">' . fields_types::get_option($v['type'],'name',$v['name'])  . '</label></td>
            <td>' . fields_types::render($v['type'],$v,$obj). '</td>
          </tr>
        ';
      }
      
      $html .= '</table></div>';
      
      $count++;
    }
    
    $html .= '</div>';
  
  }
  else
  {  
    
    $fields_query = db_query("select f.* from app_fields f where f.type not in (" . fields_types::get_reserverd_types_list(). ",'fieldtype_user_accessgroups','fieldtype_user_status','fieldtype_user_skin') and  f.entities_id='" . db_input($current_entity_id) . "' order by f.sort_order, f.name");
    while($v = db_fetch_array($fields_query))
    {           
      $html .= '
        <div class="form-group">
        	<label class="col-md-3 control-label" for="fields_' . $v['id'] . '">' . fields_types::get_option($v['type'],'name',$v['name']) . '</label>
          <div class="col-md-9">	
        	  ' . fields_types::render($v['type'],$v,$obj) 
              . tooltip_text($v['tooltip']) . '
          </div>			
        </div>
      ';    
    }    
  }
  
  echo $html;
?>

    <div id="form-error-container"></div>
          
  </div>
  
<div class="form-actions fluid">
	<div class="row">
		<div class="col-md-12">
			<div class="col-md-offset-3 col-md-9">				
        <?php echo submit_tag(TEXT_BUTTON_SAVE,array('class'=>'btn btn-primary')) ?>
			</div>
		</div>
	</div>
</div>  
  
</form> 

  </div>
</div>

<script>
  $(function() { 
                        
    $('#account_form').validate({
      ignore:'',         
      messages: {		        	    
        <?php echo fields::render_required_messages($current_entity_id); ?>			   
			},
      submitHandler: function(form)
      {      
        <?php if($current_entity_id==1){ echo 'validate_user_form(form,\'' . url_for('users/validate_form', 'id=' . $app_logged_users_id ). '\');'; }else{ echo 'form.submit();'; } ?>        
      },      
      invalidHandler: function(e, validator) {
  			var errors = validator.numberOfInvalids();
  			if (errors) {
  				var message = '<?php echo TEXT_ERROR_GENERAL ?>';
  				$("div#form-error-container").html('<div class="note note-danger">'+message+'</div>');
  				$("div#form-error-container").show();
          $("div#form-error-container").delay(5000).fadeOut();				
  			} 
		  }
      
    });  
    
    //validate user photo
    $( "#fields_10" ).rules( "add", {
        required: false,
        extension: "gif|jpeg|jpg|png" 
    }); 
        
    $('#form_tabs a').click(function (e) {
      e.preventDefault();
      $(this).tab('show');
    })    
                                                                 
  });
</script>  
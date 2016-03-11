<?php

class fieldtype_related_records
{
  public $options;
  
  function __construct()
  {
    $this->options = array('title' => TEXT_FIELDTYPE_RELATED_RECORDS_TITLE);
  }
  
  function get_configuration($params = array())
  {  
    $entity_info = db_find('app_entities',$params['entities_id']);
    
    $cfg = array();
    $cfg[] = array('title'=>TEXT_SELECT_ENTITY, 
                   'name'=>'entity_id',
                   'tooltip'=>TEXT_FIELDTYPE_RELATED_RECORDS_SELECT_ENTITY_TOOLTIP . ' ' . $entity_info['name'],
                   'type'=>'dropdown',
                   'choices'=>entities::get_choices(),
                   'params'=>array('class'=>'form-control input-medium'));
                   
    $cfg[] = array('name'=>'fields_in_listing','type'=>'hidden');
    $cfg[] = array('name'=>'fields_in_popup','type'=>'hidden');
                           
    return $cfg;
  }  
  
  function render($field,$obj,$params = array())
  {
    return false;
  }
  
  function process($options)
  {        
    return false;
  }
  
  function output($options)
  {
    global $current_path_array, $current_entity_id, $current_item_id, $current_path,$app_user;
    
    $cfg = fields_types::parse_configuration($options['field']['configuration']);
    
    //output count of relation items in listing or export
    if(isset($options['is_listing']) or isset($options['is_export']))
    {
      return $options['value'];
    }
    
    
    $access_schema = users::get_entities_access_schema($cfg['entity_id'],$app_user['group_id']);
    
    $entity_info = db_find('app_entities',$cfg['entity_id']);
    $entity_cfg = entities::get_cfg($cfg['entity_id']);
        
    $current_entity_info = db_find('app_entities',$current_entity_id);
    
    $comments_access_schema = users::get_comments_access_schema($cfg['entity_id'],$app_user['group_id']);
            
    //output list of relation items on info page
    $html = '';
           
    $items_list = array();
    
    $related_items_query = db_query("select * from app_related_items where entities_id = '"  . db_input($current_entity_id) . "' and items_id = '" . db_input($current_item_id) . "' and related_entities_id='" . db_input($cfg['entity_id']) . "'");
    while($related_items = db_fetch_array($related_items_query))
    {         
    
      //check assigned access
      if(users::has_access('view_assigned',$access_schema) and $app_user['group_id']>0)
      {
        if(!users::has_access_to_assigned_item($cfg['entity_id'],$related_items['related_items_id']))
        {
          continue; 
        }
      }
       
      $heading_field_id = fields::get_heading_id($related_items['related_entities_id']);
      
      //prepare forumulas query
      $listing_sql_query_select = fieldtype_formula::prepare_query_select($related_items['related_entities_id'], '');
          
      $item_info_query = db_query("select e.* " . $listing_sql_query_select . " from app_entity_" . $related_items['related_entities_id'] . " e where id='" . $related_items['related_items_id'] . "'");
      $item_info = db_fetch_array($item_info_query);
      
    
      $name =  ($heading_field_id>0 ? items::get_heading_field_value($heading_field_id,$item_info)  : $item_info['id']);
      
      $path_info = items::get_path_info($related_items['related_entities_id'],$related_items['related_items_id']);
    
      $items_list[] = array('path'=>$path_info['full_path'],
                            'name'=>$name,
                            'related_id'=>$related_items['id'],
                            'id'=>$item_info['id'],
                            'parent_item_id' => $item_info['parent_item_id'],
                            'fields_in_listing'  => fields::get_items_fields_data_by_id($item_info,$cfg['fields_in_listing'],$related_items['related_entities_id'],$path_info['full_path']),
                            'fields_in_popup'    => fields::get_items_fields_data_by_id($item_info,$cfg['fields_in_popup'],$related_items['related_entities_id'],$path_info['full_path']),
                            );
    }
    
    $related_items_query = db_query("select * from app_related_items where related_entities_id='" . db_input($current_entity_id) . "' and related_items_id='" . db_input($current_item_id) . "' and entities_id = '"  . db_input($cfg['entity_id']) . "'");
    while($related_items = db_fetch_array($related_items_query))
    {    
      //check assigned access
      if(users::has_access('view_assigned',$access_schema) and $app_user['group_id']>0)
      {
        if(!users::has_access_to_assigned_item($cfg['entity_id'],$related_items['items_id']))
        {
          continue; 
        }
      }
                    
      $heading_field_id = fields::get_heading_id($related_items['entities_id']);
      
       //prepare forumulas query
      $listing_sql_query_select = fieldtype_formula::prepare_query_select($related_items['entities_id'], '');
          
      $item_info_query = db_query("select e.* " . $listing_sql_query_select . " from app_entity_" . $related_items['entities_id'] . " e where id='" . $related_items['items_id'] . "'");
      $item_info = db_fetch_array($item_info_query);
    
      $name =  ($heading_field_id>0 ? items::get_heading_field_value($heading_field_id,$item_info)  : $item_info['id']);
      
      $path_info = items::get_path_info($related_items['entities_id'],$related_items['items_id']);
    
      $items_list[] = array('path'=>$path_info['full_path'],
                            'name'=>$name,
                            'related_id'=>$related_items['id'],
                            'id'=>$item_info['id'],
                            'parent_item_id' => $item_info['parent_item_id'],
                            'fields_in_listing'  => fields::get_items_fields_data_by_id($item_info,$cfg['fields_in_listing'],$related_items['entities_id'],$path_info['full_path']),
                            'fields_in_popup'    => fields::get_items_fields_data_by_id($item_info,$cfg['fields_in_popup'],$related_items['entities_id'],$path_info['full_path']),
                            );            
    }
        
    
    //echo '<pre>';    
    //print_r($items_list);
    //echo '</pre>';
          
    if(count($items_list)>0)    
    {      
      $html .= '
      <div class="table-scrollable">
        <table class="table">';
      
      foreach($items_list as $item)
      {      
        //get fields in popup
        $popup_html = '';
        if(count($item['fields_in_popup']))
        {
          $popup_html = '<table class=popover-table-data>';
          foreach($item['fields_in_popup'] as $fields)
          {
            $popup_html .= '
              <tr>
                <td>' . htmlspecialchars(strip_tags($fields['name'])) . '</td>
                <td>' . htmlspecialchars(strip_tags($fields['value'])) . '</td>
              </tr>
            ';
          }
          $popup_html .= '</table>';
          
          $popup_html = 'data-toggle="popover" data-content="' . addslashes(str_replace(array("\n","\r","\n\r"),' ',$popup_html)) . '"'; 
        }
        
        //added comments info
        $comments_html = '';
        if($entity_cfg['use_comments']==1 and users::has_comments_access('view',$comments_access_schema))
        {                    
          $comments_html = ' <span style="white-space:nowrap">' . comments::get_last_comment_info($cfg['entity_id'],$item['id'],$item['path']) . '</span>';
        }
                
        //add paretn item name if exist
        $parent_name = '';
        if($entity_info['parent_id']!=$current_entity_info['parent_id'] and $entity_info['parent_id']>0)
        {
          $parent_name = items::get_heading_field($entity_info['parent_id'],$item['parent_item_id']) . ' <i class="fa fa-angle-right"></i> ';
        }
        
        
        $html .= '
          <tr id="related-records-' . $item['related_id'] . '">
            <td class="related-records-name">
              <a ' . $popup_html . ' href="' . url_for('items/info','path=' . $item['path']). '">' . $parent_name . $item['name']. '</a>' . $comments_html . '</td>';
                
        //render fields in listing
        if(count($item['fields_in_listing']))
        {
          foreach($item['fields_in_listing'] as $fields)
          {
            $html .= '<td>' . $fields['value'] . '</td>';
          }
        }    
            
        $html .= '            
            <td align="right"> ' . (users::has_access('update',$access_schema) ? '<a onClick="return app_remove_related_item(' . $item['related_id'] . ')" href="" title="' . TEXT_BUTTON_DELETE_RELATION . '" class="btn btn-default btn-xs btn-xs-fa-centered"><i class="fa fa-chain-broken"></i></a>':'') . '</td>
          </tr>
        ';
      }
      
      $html .= '
        </table>
      </div>';
    }
    
    //if parent items are different    
    if($entity_info['parent_id']!=$current_entity_info['parent_id'] and $entity_info['parent_id']>0)
    {
      $add_url = url_for('reports/prepare_add_item','reports_id=' . reports::get_default_entity_report_id($cfg['entity_id'],'entity_menu') . '&related=' . $current_entity_id . '-' . $current_item_id);
    }
    //if parent items are the same
    elseif($entity_info['parent_id']==$current_entity_info['parent_id'] and $entity_info['parent_id']>0)
    {     
      $path = app_get_path_to_parent_item($current_path_array) . '/' . $cfg['entity_id'];
      
      $add_url = url_for('items/form','path=' . $path . '&related=' . $current_entity_id . '-' . $current_item_id);
    }
    else
    {
      $path = $cfg['entity_id'];
      
      $add_url = url_for('items/form','path=' . $path . '&related=' . $current_entity_id . '-' . $current_item_id);
    } 
    
    
    if(users::has_access('create',$access_schema))
    {
      $html .= '
        <div class="action-button">
        
          ' . link_to_modalbox('<i class="fa fa-plus"></i> ' . TEXT_BUTTON_ADD,$add_url,array('class'=>'btn btn-default btn-xs')) . ' &nbsp;          
          ' . link_to_modalbox('<i class="fa fa-link"></i> ' . TEXT_BUTTON_LINK,url_for('items/link_related_item','path=' . $current_path . '&related_entities=' . $cfg['entity_id']),array('class'=>'btn btn-default btn-xs')) . ' &nbsp;        
        </div>
        <script>
          function app_remove_related_item(id)
          {
            if(confirm(i18n["TEXT_ARE_YOU_SURE"]))
            {
              $.ajax({
                type: "POST",
                url: "' . url_for('items/items','action=remove_related_item&path=' . $current_path). '&id="+id,
                data: { id: id}
              }).done(function(){
                $("#related-records-"+id).fadeOut();
              })
            }
            return false;
          }
        </script>
        ';
      }
    
    
    return $html;
  }  
  
  function reports_query($options)
  {
    $filters = $options['filters'];
    $sql_query = $options['sql_query'];
  
    $sql = array();
    
    if(strlen($filters['filters_values'])>0)
    {
      $sql_query[] = ($filters['filters_values']=='include' ? "field_" . $filters['fields_id'] . ">0": "(field_" . $filters['fields_id'] . "=0 or length(field_" . $filters['fields_id'] . ")=0)") ;
    }
                      
    return $sql_query;
  }  
}
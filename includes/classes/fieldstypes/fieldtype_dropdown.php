<?php

class fieldtype_dropdown
{
  public $options;
  
  function __construct()
  {
    $this->options = array('title' => TEXT_FIELDTYPE_DROPDOWN_TITLE,'has_choices'=>true);
  }
  
  function get_configuration()
  {
    $cfg = array();
    $cfg[] = array('title'=>TEXT_WIDHT, 
                   'name'=>'width',
                   'type'=>'dropdown',
                   'choices'=>array('input-small'=>TEXT_INPTUT_SMALL,'input-medium'=>TEXT_INPUT_MEDIUM,'input-large'=>TEXT_INPUT_LARGE,'input-xlarge'=>TEXT_INPUT_XLARGE),
                   'tooltip'=>TEXT_ENTER_WIDTH,
                   'params'=>array('class'=>'form-control input-medium'));
    
    $cfg[] = array('title'=>TEXT_USE_SEARCH, 
                   'name'=>'use_search',
                   'type'=>'dropdown',
                   'choices'=>array('0'=>TEXT_NO,'1'=>TEXT_YES),
                   'tooltip'=>TEXT_USE_SEARCH_INFO,
                   'params'=>array('class'=>'form-control input-medium')); 
        
    $cfg[] = array('title'=>TEXT_NOTIFY_WHEN_CHANGED, 'name'=>'notify_when_changed','type'=>'checkbox','tooltip'=>TEXT_NOTIFY_WHEN_CHANGED_TIP);                          
    
    return $cfg;
  }  
  
  function render($field,$obj,$params = array())
  {
    $cfg = fields_types::parse_configuration($field['configuration']);
            
    $attributes = array('class'=>'form-control ' . $cfg['width'] . ' field_' . $field['id'] . ($field['is_required']==1 ? ' required':'') . ($cfg['use_search']==1 ? ' chosen-select':''),
                        'data-placeholder'=>TEXT_SELECT_SOME_VALUES);
                        
    $choices = fields_choices::get_choices($field['id'],($field['is_required']==1 ? false:true));
    
    $value = ($obj['field_' . $field['id']]>0 ? $obj['field_' . $field['id']] : ($params['form']=='comment' ? '':fields_choices::get_default_id($field['id']))); 
    
    return select_tag('fields[' . $field['id'] . ']',$choices,$value,$attributes);
  }
  
  function process($options)
  {
    global $app_changed_fields, $app_choices_cache;
    
    if(!$options['is_new_item'])
    {
      $cfg = fields_types::parse_configuration($options['field']['configuration']);
      
      if($options['value']!=$options['current_field_value'] and $cfg['notify_when_changed']==1)
      {
        $app_changed_fields[] = array('name'=>$options['field']['name'],'value'=>$app_choices_cache[$options['value']]['name']);
      }
    }
  
    return $options['value'];
  }
  
  function output($options)
  {
    return fields_choices::render_value($options['value'],$options['choices_cache']);
  }  
  
  function reports_query($options)
  {
    $filters = $options['filters'];
    $sql_query = $options['sql_query'];
  
    $sql_query[] = $options['prefix'] . 'field_' . $filters['fields_id'] .  ($filters['filters_condition']=='include' ? ' in ': ' not in ') .'(' . $filters['filters_values'] . ') ';
    
    return $sql_query;
  }
}
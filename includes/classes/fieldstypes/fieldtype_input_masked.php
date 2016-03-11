<?php

class fieldtype_input_masked
{
  public $options;
  
  function __construct()
  {
    $this->options = array('title' => TEXT_FIELDTYPE_INPUT_MASKED);
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
                   
    $cfg[] = array('title'=>TEXT_INPUT_FIELD_MASK, 'name'=>'mask','type'=>'input','tooltip'=>TEXT_INPUT_FIELD_MASK_TIP,'params'=>array('class'=>'form-control'));                         
    
    return $cfg;
  }
  
  function render($field,$obj,$params = array())
  {
    $cfg = fields_types::parse_configuration($field['configuration']);
    
    $attributes = array('class'=>'form-control ' . $cfg['width'] . ' fieldtype_input field_' . $field['id'] . ($field['is_required']==1 ? ' required':''));
    
    $script = '';
    
    if(strlen($cfg['mask'])>0)
    {
      $script = '
        <script>
          jQuery(function($){         
             $("#fields_' . $field['id'] . '").mask("' . $cfg['mask'] . '");                 
          });
        </script>
      ';
    }
    
    return input_tag('fields[' . $field['id'] . ']',$obj['field_' . $field['id']],$attributes) . $script;
  }
  
  function process($options)
  {
    return $options['value'];
  }
  
  function output($options)
  {
    return $options['value'];
  }
}
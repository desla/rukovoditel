<?php
/*
//prepare forumulas query
$formulas_sql_query_select_array = fieldtype_formula::prepare_query_select($current_entity_id, array());

//echo '<pre>';
//print_r($formulas_sql_query_select_array);
//echo '</pre>';

$sum_sql_query = array();
foreach($listing_numeric_fields as $id)
{
  $field_name = "field_" . $id;
  
  foreach($formulas_sql_query_select_array as $formulas_sql_query_select)
  {
    
    if(strstr($formulas_sql_query_select,'as ' . $field_name))
    {    
      if(preg_match('/(.*?) as ' . $field_name . '/',$formulas_sql_query_select,$matches))
      {
        //echo '<pre>';
        //print_r($matches);
        //echo '</pre>';
        
        $field_name = $matches[1];
      }
    }
  }
   
  $sum_sql_query[] = "sum(" . $field_name . ") as total_" . $id;
}

//echo '<pre>';
//print_r($sum_sql_query);
//echo '</pre>';

$totals_query = db_query("select " . implode(', ',$sum_sql_query) . " from app_entity_" . $current_entity_id . " e "  . $listing_sql_query_join . " where e.id>0 " . $listing_sql_query);
$totals = db_fetch_array($totals_query);

$html .= '
  <tfoot>
    <tr>
      <td></td>
';
foreach($listing_fields as $field)
{
  if(in_array($field['id'],$listing_numeric_fields))
  {
    $value = $totals['total_' . $field['id']];
    
    if(strstr($value,'.'))
    {
      $value = number_format($value,2,'.','');
    }
     
    $html .= '<td>' . $value . '</td>';
  }
  else
  {
    $html .= '<td></td>'; 
  }
}

if($reports_entities_id>0  and $current_entity_info['parent_id']>0 and strlen($app_redirect_to)>0)
{
  $html .= '<td></td>';
}

$html .= '
    </tr>
  </tfoot>   
';
*/
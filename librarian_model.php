<?php 
  
class Librarian_model extends CI_Model{ 
  
    
    public function edit($stmt){
      $this->db->query($stmt);
    }

    public function get($sql){
        $q = $this->db->query($sql);
        if($q->num_rows()>0){
            foreach($q->result() as $row){
                $data[] = $row;
            }
        }
        return $data;
    }
 
} 
  
?>
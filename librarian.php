<?php
	class Librarian extends CI_Controller {
		public function index()
		{
			parent::__construct();
		
			$this->load->view('sample');
		}

		public function load_database(){
			/* $id here could be from a $_POST or $_SESSION */
			$id = 1;
	       	$this->load->model('librarian_model');
	        $data['reference_material'] = $this->librarian_model->get("select * from reference_material where id='$id'");        
	      	$this->load->view('edit_reference_view', $data);
	    }

	    public function view_reference(){
	    	/* $id here could be from a $_POST or $_SESSION */
			$id = 1;
	       	$this->load->model('librarian_model');
	        $data['reference_material'] = $this->librarian_model->get("select * from reference_material where id='$id'");        
	      	$this->load->view('view_reference_view', $data);
	    }

		public function edit_reference(){

			session_start();
			$id = $_SESSION['id'];
			$title = mysql_real_escape_string(trim($this->input->post('title')));
			//$title = $this->input->post('title');
			$author = $this->input->post('author');
			$isbn = $this->input->post('isbn');
			$category = $this->input->post('category');
			$publisher = mysql_real_escape_string(trim($this->input->post('publisher')));
			$publication_year = $this->input->post('publication_year');
			$access_type = $this->input->post('access_type');
			$course_code = $this->input->post('course_code');
			$description = mysql_real_escape_string(trim($this->input->post('description')));
			$total_stock = $this->input->post('total_stock');


	       	$this->load->model('librarian_model');
	        $this->librarian_model->edit("UPDATE reference_material SET title = '$title', author = '$author', isbn = '$isbn', category = '$category', publisher = '$publisher', publication_year = '$publication_year', access_type = '$access_type', course_code = '$course_code', description = '$description', total_stock = $total_stock WHERE id = $id");
	        $this->load->view('success');
	    }	    


		
	}
?>
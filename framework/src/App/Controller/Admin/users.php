<?php

namespace App\Controller\Admin;

use Framework\Controller\AbstractController;
require_once __DIR__ . '/../../Users/CrudUsers.php';

class Users extends AbstractController
{

    public function __invoke()
    {
        if(isset($_POST['delete'])){
            deleteUser($_POST['id_user']);
        }else if (isset($_POST['update'])){
            updateUser($_POST);
        }else if(isset($_POST['insert'])){
            insertUser($_POST);
        }
        $users = getUsers();
        return $this->render('admin/users.html.twig', [
            'users' => $users
        ]);        
    }

}
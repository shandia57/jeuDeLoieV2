<?php

namespace App\Controller\Admin;

use Framework\Controller\AbstractController;
use App\Classes\User;
use App\Classes\Admin\Questions\Questions;
use App\Classes\Admin\Answers\Answers;
use App\Classes\Admin\Questions_Answers\QuestionsAnswers;
use  App\Classes\ControlDataForm\ControlQuestionsForm;
use  App\Classes\ControlDataForm\ControlAnswersForm;




class Question extends AbstractController
{


    public function __invoke(): string
    {
 
        session_start();

        $this->isConnected = $_SESSION['user'] ?? null;
        $this->createUserSessionWithCookie();
        Question::isAdmin();



        $question = new Questions();
        $answer = new Answers();
        $questionsAnswers = new QuestionsAnswers();
        $controlQuestionsForm = new ControlQuestionsForm();
        $controlAnswersForm = new ControlAnswersForm();

        if(!empty($_POST))
        {
            $this->controlPostSended($controlAnswersForm, $controlQuestionsForm, $question, $answer, $questionsAnswers);
        }



        $users = (new User)->getUsers();
        $questions = $question->getAllQuestions();

        return $this->render('Admin/questions.html.twig', [
            'user' => $this->isConnected['username'],
            'user_roles' => $this->isConnected['roles'],
            'title' => "Questions",
            'questions' => $questions, 
            'label' =>  $controlQuestionsForm->displayErrors("label"),
            'level' =>  $controlQuestionsForm->displayErrors("level"),
            'question' =>  $controlQuestionsForm->displayErrors("question"),
            "answer" => $controlAnswersForm->displayErrors("answer"),
            "nbrUsers" => count($users),
            "nbrQuestions" => count($questions),
            "anyErrors" => $this->anyErrors,

        ]);
    }


    public function insertQuestionsAndAnswers($question, $answer, $questionsAnswers, $details) : void
    {
            $id_question = $question->getMaxNumberIdQuestions();
            $id_question = $question->returnNumberIfEmptyID($id_question);

            $question->insertQuestion($details, $id_question);

            for($i = 0; $i < count($details['answer']); $i++){

                if(isset($_POST["validAnswer" .$i + 1])){
                    $validAnswer = 1;
                    $answer->insertAnswer($details['answer'][$i], $validAnswer);
        
                }else{
                    $validAnswer = 0;
                    $answer->insertAnswer($details['answer'][$i], $validAnswer);
                }

                $id_answer = $answer->getNumberIdAnswer();
                $id_answer = $answer->returnNumberIfEmptyID($id_answer);

                $questionsAnswers->linkQuestionWithAnswer($id_question, $id_answer);
            }
    }

    public function insert($controlAnswersForm, $controlQuestionsForm, $question, $answer, $questionsAnswers): void
    {
        $controlAnswersForm->findErrosIntoArray($_POST['answer']);
        $controlQuestionsForm->findError($controlQuestionsForm->getValidations(), $_POST, null);
        if(empty($controlQuestionsForm->getErrors())){
            $this->insertQuestionsAndAnswers($question, $answer, $questionsAnswers, $_POST);
        }else{
            $this->anyErrors = "L'ajout d'une nouvelle question à échoué, cliquez sur 'Ajouter une nouvelle question' pour avoir plus de détails";
        }
    }

    public function update($question, $controlQuestionsForm) : void
    {
        $controlQuestionsForm->findError($controlQuestionsForm->getValidations(), $_POST, null);            
        if(empty($controlQuestionsForm->getErrors())){
            $question->updateQuestion($_POST);
        }
    }

    public function delete($question) : void
    {
        $question->deleteQuestion($_POST['idQuestionsUpdate']);
    }

    public function controlPostSended($controlAnswersForm, $controlQuestionsForm, $question, $answer, $questionsAnswers) : void
    {
        if (isset($_POST['insertQuestion'])) {
            $this->insert($controlAnswersForm, $controlQuestionsForm, $question, $answer, $questionsAnswers);
        
        }else if (isset($_POST['UpdateQuestions'])){

            $this->update($question, $controlQuestionsForm);

        }else if (isset($_POST['deleteQuestions']) && $_POST['deleteQuestions'] === "true"){
            $this->delete($question);

        }else if (isset($_POST['logout']) && $_POST['logout'] === "true"){
            $this->logout();
        }
    }
  
}

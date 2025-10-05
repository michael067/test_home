<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $to = "michael.mathieu@gmail.com";
    $subject = "Message du site de contact";
    $message = "Nom: " . $_POST["name"] . "\n" .
               "Email: " . $_POST["email"] . "\n\n" .
               "Message:\n" . $_POST["message"];

    $headers = "From: " . $_POST["email"];

    if (mail($to, $subject, $message, $headers)) {
        echo "✅ Message envoyé avec succès.";
    } else {
        echo "❌ Échec de l'envoi du message.";
    }
}
?>

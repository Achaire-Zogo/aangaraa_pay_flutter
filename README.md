# Aangaraa Pay Flutter Plugin

Un plugin Flutter pour intégrer facilement les paiements MTN Mobile Money et Orange Money au Cameroun dans vos applications Flutter.

## Installation

```yaml
dependencies:
  aangaraa_pay_flutter: ^0.0.1
```

Ou ajoutez directement depuis GitHub :

```yaml
dependencies:
  aangaraa_pay_flutter:
    git:
      url: https://github.com/votre-username/aangaraa_pay_flutter.git
      ref: main
```

## Configuration

Initialisez le plugin avec votre clé d'API et l'URL de base de votre API :

```dart
final aangaraaPay = AangaraaPayFlutter();

await aangaraaPay.initialize(
  apiKey: 'VOTRE_CLE_API',
  baseUrl: 'YOUR_API_BASE_URL',
);
```

## Utilisation

### Effectuer un paiement

Pour effectuer un paiement, utilisez la méthode `initiatePayment`. Vous devez spécifier l'opérateur (soit `MTN_Cameroon` soit `Orange_Cameroon`), ainsi que les autres détails de paiement.

```dart
try {
  final result = await aangaraaPay.initiatePayment(
    operator: 'MTN_Cameroon', // ou 'Orange_Cameroon'
    amount: '1000',
    currency: 'XAF',
    phoneNumber: '237600000000',
    description: 'Paiement test',
    transactionId: 'UNIQUE_TRANSACTION_ID',
    returnUrl: 'YOUR_RETURN_URL',
    notifyUrl: 'YOUR_NOTIFY_URL',
    apiKey: 'YOUR_API_KEY',
    baseUrl: 'YOUR_API_BASE_URL',
  );
  
  print('Status: ${result['status']}');
  print('Transaction ID: ${result['transaction_id']}');
} catch (e) {
  print('Erreur: $e');
}
```

### Paramètres de `initiatePayment`
- `operator`: L'opérateur de paiement (MTN ou Orange)
- `amount`: Montant à payer
- `currency`: Devise (ex: XAF)
- `phoneNumber`: Numéro de téléphone du client
- `description`: Description de la transaction
- `transactionId`: Identifiant unique de la transaction
- `returnUrl`: URL de retour après le paiement
- `notifyUrl`: URL de notification pour les mises à jour de transaction
- `apiKey`: Clé d'API pour l'authentification
- `baseUrl`: URL de base de votre API

### Vérifier le statut d'une transaction

```dart
try {
  final status = await aangaraaPay.checkTransactionStatus('TRANSACTION_ID');
  print('Status: ${status['status']}');
} catch (e) {
  print('Erreur: $e');
}
```

## Exemple complet

Consultez le dossier [example](example) pour voir un exemple complet d'intégration.

## Fonctionnalités

- Paiement MTN Mobile Money
- Paiement Orange Money
- Vérification du statut des transactions
- Support du mode sandbox pour les tests
- Gestion des erreurs
- Documentation complète

## Contribution

Les contributions sont les bienvenues ! N'hésitez pas à :

1. Fork le projet
2. Créer une branche pour votre fonctionnalité (`git checkout -b feature/AmazingFeature`)
3. Commit vos changements (`git commit -m 'Add some AmazingFeature'`)
4. Push vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrir une Pull Request

## Licence

Ce projet est sous licence MIT - voir le fichier [LICENSE](LICENSE) pour plus de détails.

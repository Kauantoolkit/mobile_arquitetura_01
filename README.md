# mobile_arquitetura_01

Um projeto Flutter demonstrando clean architecture com camadas de dados, domínio e apresentação. Consome a API FakeStore (https://fakestoreapi.com/products).

## Arquitetura

Este projeto segue os princípios de Clean Architecture com as seguintes camadas:

```
lib/
  core/
    errors/
      failure.dart          # Classe de exceção para falhas
    network/
      http_client.dart     # Wrapper do cliente HTTP usando o pacote http
  domain/
    entities/
      product.dart         # Entidade Product (imutável)
    repositories/
      product_repository.dart  # Interface abstrata do repositório
  data/
    models/
      product_model.dart   # ProductModel com serialização JSON
    datasources/
      product_remote_datasource.dart   # Fonte de dados da API remota
      product_cache_datasource.dart    # Fonte de dados de cache em memória
    repositories/
      product_repository_impl.dart     # Implementação do repositório
  presentation/
    viewmodels/
      product_state.dart    # Classe de estado para produtos
      product_viewmodel.dart # ViewModel gerenciando o estado dos produtos
    pages/
      product_page.dart     # Página principal exibindo produtos
    widgets/
      product_tile.dart    # Widget de cartão de produto reutilizável
  main.dart                 # Ponto de entrada do app com configuração de DI
```

## Pacote HTTP Utilizado

Este projeto usa o pacote **http** (versão 1.6.0) para fazer requisições de rede. É um cliente HTTP simples e leve para Dart/Flutter.

## Como Executar

1. **Instalar dependências:**
   ```bash
   flutter pub get
   ```

2. **Executar o app:**
   ```bash
   flutter run
   ```

3. **Build para Android:**
   ```bash
   flutter build apk
   ```

4. **Build para iOS:**
   ```bash
   flutter build ios
   ```

## Como Testar Falha de Rede

Para testar o tratamento de erros e comportamento de cache:

1. **Testar sem internet:**
   - Desconecte seu dispositivo/computador da rede
   - Toque no botão de atualizar (FAB)
   - Se os produtos foram carregados antes, aparecerão do cache
   - Se nenhum produto foi carregado antes, você verá uma mensagem de erro

2. **Simular falha de rede no código:**
   - Você pode modificar o `ProductRemoteDatasource` para lançar uma exceção
   - Ou alterar temporariamente a URL da API para um endpoint inválido

## Tratamento de Erros

- **Erros de rede:** Exibe a mensagem "Não foi possível carregar os produtos"
- **Fallback de cache:** Se a rede falhar mas existir cache, exibe os produtos em cache
- **Estado vazio:** Exibe mensagem apropriada quando não houver produtos disponíveis

## Funcionalidades

- Clean Architecture (camadas de dados, domínio e apresentação)
- Consome https://fakestoreapi.com/products
- Cache em memória para suporte offline
- Tratamento de erros com mensagens amigáveis
- Pull-to-refresh via botão FAB
- Null safety
- Material Design 3

## Commits

- `init: flutter project mobile_arquitetura_01` - Configuração inicial do projeto Flutter
- Commits adicionais para implementação de cada camada

## Versão

v1.0.0


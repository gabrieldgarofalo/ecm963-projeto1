import 'dart:io';
import 'dart:math';

void exibeTexto(String texto) {
  print(texto);
}

int pegaOpcaoUsuario() {
  return int.parse(stdin.readLineSync()!);
}

bool opcaoEhValida(int opcao, bool isDadoMagico) {
  if (isDadoMagico) {
    return opcao == 0 || opcao == 1;
  } else {
    return opcao >= 0;
  }
}

List<int> rolaDados() {
  Random rand = Random();
  return [rand.nextInt(6) + 1, rand.nextInt(6) + 1, rand.nextInt(6) + 1];
}

int rolaDadoMagico() {
  Random rand = Random();
  return rand.nextInt(2);
}

int somaDados(List<int> dados) {
  int soma = 0;
  for (int dado in dados) {
    soma += dado;
  }
  return soma;
}

String defineResultadoRodada(num jogador, num computador, Map placarFinal) {
  if (jogador > computador) {
    placarFinal['jogador'] += 1;
    return "Jogador venceu!\n";
  } else if (jogador < computador) {
    placarFinal['computador'] += 1;
    return "Computador venceu!\n";
  } else {
    placarFinal['empate'] += 1;
    return "Empate\n";
  }
}

String defineResultadoFinal(Map placarFinal) {
  if (placarFinal['jogador'] > placarFinal['computador'] &&
      placarFinal['jogador'] > placarFinal['empate']) {
    return "Jogador venceu o jogo!";
  } else if (placarFinal['computador'] > placarFinal['jogador'] &&
      placarFinal['computador'] > placarFinal['empate']) {
    return "Computador venceu o jogo!";
  } else if (placarFinal['empate'] > placarFinal['jogador'] &&
      placarFinal['empate'] > placarFinal['computador']) {
    return "Empatou!";
  } else {
    return "Não foi possível determinar o resultado final :(";
  }
}

void jogo() {
  int nRodadas;
  bool eValido;
  bool eValidoDadoMagico;
  String resultadoFinal;
  Map<String, int> placarFinal = {'jogador': 0, 'empate': 0, 'computador': 0};
  bool dadoMagicoJaFoiUsado = false;
  bool dadoMagico = false;
  int valorDadoMagico;
  int resultadoDadoMagico = 0;
  exibeTexto(
      'Bem-vindo ao jogo dos dados!\nEscolha o número de rodadas que quer jogar ou 0 se quiser sair.');
  nRodadas = pegaOpcaoUsuario();
  eValido = opcaoEhValida(nRodadas, false);
  if (eValido) {
    if (nRodadas > 0) {
      for (var i = 0; i < nRodadas; i++) {
        if (!dadoMagico && !dadoMagicoJaFoiUsado) {
          exibeTexto(
              "Digite 1 para usar o dado mágico nessa rodada ou 0 para usar em uma das próximas:");
          valorDadoMagico = pegaOpcaoUsuario();
          eValidoDadoMagico = opcaoEhValida(valorDadoMagico, true);
          if (eValidoDadoMagico) {
            if (valorDadoMagico == 1) {
              dadoMagico = true;
              dadoMagicoJaFoiUsado = true;
              exibeTexto("Usando dado mágico!");
              resultadoDadoMagico = rolaDadoMagico();
              exibeTexto("Valor do dado mágico $resultadoDadoMagico");
            }
          } else {
            exibeTexto(
                "Valor do dado mágico inválido, espere a próxima rodada para usar!");
          }
        }
        List<int> dadosJogador = rolaDados();
        List<int> dadosComputador = rolaDados();
        num somaDadoJogador = somaDados(dadosJogador);
        num somaDadoComputador = somaDados(dadosComputador);
        if (dadoMagico) {
          exibeTexto("Soma antes do dado mágico: $somaDadoJogador");
          if (resultadoDadoMagico == 1) {
            somaDadoJogador = somaDadoJogador * 2;
          } else {
            somaDadoJogador = somaDadoJogador / 2;
          }
          exibeTexto("Soma depois do dado mágico: $somaDadoJogador");
          dadoMagico = false;
        }
        String resultado = defineResultadoRodada(
            somaDadoJogador, somaDadoComputador, placarFinal);
        exibeTexto(
            "Rodada ${i + 1}:\nDados\tJogador\tComputador\nDado 1\t${dadosJogador[0]}\t${dadosComputador[0]}\nDado 2\t${dadosJogador[1]}\t${dadosComputador[1]}\nDado 3\t${dadosJogador[2]}\t${dadosComputador[2]}\nSoma:\t$somaDadoJogador\t$somaDadoComputador");
        exibeTexto("Resultado da rodada: $resultado");
      }
      exibeTexto(
          "Placar Final:\nVitórias Jogador: ${placarFinal['jogador']}\nEmpates: ${placarFinal['empate']}\nVitórias Computador: ${placarFinal['computador']}");
      resultadoFinal = defineResultadoFinal(placarFinal);
      exibeTexto("Resultado Final: $resultadoFinal");
    } else {
      exibeTexto("Obrigado por jogar!");
    }
  } else {
    exibeTexto("Valor Inválido");
  }
}

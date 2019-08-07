package com.try_java;

import lombok.Value;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

// Java with a Clojure mindset
// https://danlebrero.com/2019/03/06/java-with-a-clojure-mindset/

public class JavaWithClojureMindset {

  @Value
  class Pair {
    ClientBonus clientBonus;
    Effects effects;
  }

  @Value
  class AllDependencies {
  }

  class Effects {
    void run(AllDependencies dependencies) {
    }
  }

  interface Effect {
    void run(AllDependencies dependencies);
  }

  @Value
  class Client {
  }

  @Value
  class ClientBonus {

    Long client;

    // Pair<ClientBonus, Effects>
    public Pair nextState(Bet bet) {
      return new Pair(new ClientBonus(1L), new Effects());
    }
  }

  @Value
  class Bet {
    String id;
    int amount;
    long timestamp;
  }

  class TheStateHolder {
    private final Map<Long, Pair> state = new ConcurrentHashMap<>();

    // nextState function must be a pure function.
    public Pair nextState(Long client, Bet bet) {
      return state.computeIfPresent(
          client,
          (k, currentPair) -> currentPair.clientBonus.nextState(bet));
    }

    public Effects event(Bet bet) {
      return new Effects();
    }
  }

  // ask Kafka for all the messages in the last couple of months,
  // and recalculate the current state from all those events.
  // Each event is timestamped, so the application will use
  // the event time as the current time in its logic.
  TheStateHolder calculateStateFromEventSource(KafkaClient source) {
    var state = new TheStateHolder();
    source
        .readHistory().stream()
        .forEach((bet) -> state.event(bet));
    return state;
  }

  class KafkaClient {
    public List<Bet> readHistory() {
      return List.of(
          new Bet("a", 100, 1L),
          new Bet("b", 200, 2L),
          new Bet("c", 300, 3L)
      );
    }

    public Bet readNext() {
      return new Bet("z", 99, 99L);
    }

    public boolean stop() {
      return false;
    }
  }

  @Value
  public class KafkaConsumer {
    private AllDependencies allDependencies;
    private TheStateHolder theStateHolder;
    private KafkaClient kafkaClient;

    public void run() {
      while (!kafkaClient.stop()) {
        Bet bet = kafkaClient.readNext();
        Effects effects = theStateHolder.event(bet);
        effects.run(allDependencies);
      }
    }

    private Bet readNext() {
      return new Bet("z", 99, 99L);
    }
  }

  void handleBet(Bet bet, TheStateHolder state, AllDependencies dependencies) {
    Pair pair = state.nextState(1L, bet);
    pair.effects.run(dependencies);
  }

  public void main(String[] args) {
    var dependencies = new AllDependencies();
    var kafkaClient = new KafkaClient();
    var state = calculateStateFromEventSource(kafkaClient);
    var consumer = new KafkaConsumer(dependencies, state, kafkaClient);

    // Will run and update state as new events come in
    consumer.run();
  }
}

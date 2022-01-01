export class Player {

    #id
    #username;
    #role;
    #points = 0;
    #maxPoints = 49;
    #players = [];
    #maxPlayers = 6;
    #currentIndexPlayer = 0;
    #numberOfActuelPlayers;


    constructor(username, role) {
        this.setUsername(username);
        this.setRole(role);
    }

    setId(id) {
        this.#id = id;
    }

    getId() {
        return this.#id;
    }

    setUsername(username) {
        this.#username = username;
    }

    getUsername() {
        return this.#username;
    }

    setRole(role) {
        this.#role = role;
    }

    getRole() {
        return this.#role;
    }

    setPoints(points) {
        if (this.#points + points > this.#maxPoints) {
            this.#points = this.#maxPoints;
        } else {
            this.#points += points;
        }
    }

    getPoints() {
        return this.#points;
    }

    getMaxPoints() {
        return this.#maxPoints;
    }

    setPlayers(...players) {
        this.#players = players;
    }

    getPlayers() {
        return this.#players;
    }

    getMaxPlayers() {
        return this.#maxPlayers;
    }

    getNumberPlayer() {
        return this.#players.length;
    }

    getSinglePlayer(index) {
        return this.#players[index];;
    }

    IncrementCurrentIndexPlayer() {
        this.#currentIndexPlayer === this.#maxPlayers - 1 ? this.#currentIndexPlayer = 0 : this.#currentIndexPlayer += 1;
    }

    getCurrentIndexPlayer() {
        return this.#currentIndexPlayer;
    }

    getCurrentPlayer() {
        return this.#players[this.#currentIndexPlayer];
    }

    setNumberOfActuelPlayers(number) {
        this.#numberOfActuelPlayers = number;
    }

    getNumberOfActuelPlayers() {
        return this.#numberOfActuelPlayers;
    }

    controlPointsOfTheCurrentPlayer() {
        return this.#points === this.#maxPoints;
    }
}
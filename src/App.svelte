<script>
    import {Router, Link, Route} from "svelte-routing"
    import Books from "./Component/Books.svelte"
    import Movies from "./Component/Movies.svelte"
    import Quotes from "./Component/Quotes.svelte"
    import Characters from "./Component/Characters.svelte"
    export let url = '';
</script>

<Router url={url}>
    <header>
        <nav>
            <Link to="/">LotR - Svelte</Link>
            <Link to="/Books">Books</Link>
            <Link to="/Movies">Movies</Link>
            <Link to="/Quotes">Quotes</Link>
            <Link to="/Characters">Characters</Link>
        </nav>
    </header>

    <main>
        <div>
            <Route path="/Books">
                <Books/>
            </Route>
            <Route path="/Movies">
                <Movies/>
            </Route>
            <Route path="/Quotes">
                <Quotes/>
            </Route>
            <Route path="/Characters">
                <Characters/>
            </Route>
        </div>
    </main>
</Router>

<style type="text/scss">
    $orange : #ff3e00;
    header {
        width: 100%;
        display: flex;
        justify-content: space-between;
        background-color: $orange;
        color: white;
    }
    main {
        text-align: center;
        padding: 1em;
        max-width: 240px;
        margin: 0 auto;
    }
    @media (min-width: 640px){
        main{
            max-width: none;
        }
    }
</style>
<script>
    export let name;
</script>

<header>
    <span>
        LotR - Svelte
    </span>
    <nav>
        <ul>
        <li>Books</li>
        <li>Movies</li>
        <li>Quotes</li>
        <li>Characters</li>
        </ul>
    </nav>
</header>

<main>
    <h1> Hello {name} </h1>
</main>

<style type="text/scss">
    $orange : #ff3e00;
    header {
        width: 100%;
        display: flex;
        justify-content: space-between;
        background-color $orange;
        color: white;
        span {
            margin: 1rem 0 1rem .75rem;
        }
        nav {
            margin : 0 .75rem;
            ul {
                display: flex;
                padding-left: 0;
                list-style: none;
                li:not(:first-child) {
                    margin-left: .75rem;
                }
            }
        }
    }
    main {
        text-align: center;
        padding: 1em;
        max-width: 240px;
        margin: 0 auto;
        h1 {
            color: $orange;
            text-transform: uppercase;
            font-size: 4em;
            font-weight: 100;
        }
    }
    @media (min-width: 640px){
        main{
            max-width: none;
        }
    }
</style>
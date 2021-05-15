<script>
    import {onMount} from 'svelte';
import SingleMovie from './SingleMovie.svelte';
    let movies = [];

    onMount(async function(){

        if (localStorage.getItem("movies")) {
            movies = JSON.parse(localStorage.getItem("movies"));
            console.log(movies)
            return;
        }

        const response = await fetch(`${__lotr.env.API_URL}/movie`,{
            method: "GET",
            headers:{
                "Authorization": `Bearer ${__lotr.env.API_TOKEN}`,
            },
        })
        .then(result => result.json())
        .then(data => {
            localStorage.setItem("movies", JSON.stringify(data.docs));
            return movies = data.docs;
        });
    });

</script>


<main>
    <div class="background"></div>
    <h2>From the Hobbits saga to The Lord of the Rings trilogy</h2>

    {#if movies !== undefined}
        {#await movies}
            <p>Movies are loading</p>
            {:then movies}
            <div class="content">
                <div class="movies">
                    {#each movies as movie}
                        <SingleMovie movie={movie}/>
                    {/each}
                </div>
            </div>
        {/await}
    {/if}
</main>

<style type="text/scss">
    main{
        position: relative;
        height: calc(100vh - 65px);
        .background{
            background-image: url('../assets/movie-background.png');
            background-repeat: no-repeat;
            background-size: cover;
            width: 100%;
            height: 100%;
            position: fixed;
            top:0;
            left:0;
            z-index: -1;
        }
        margin-top:  65px;
        .movies{
            display: grid;
            grid-gap: 2rem;
            grid-template-columns: repeat(2, minmax(0, 1fr));
        }
    }
</style>
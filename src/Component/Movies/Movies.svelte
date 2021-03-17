<script>
    import {onMount} from 'svelte';
    let movies = [];

    onMount(async function(){

        if (localStorage.getItem("movies")) {
            movies = JSON.parse(localStorage.getItem("movies"));
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
    <h1>Movies section</h1>

    {#if movies !== undefined}
        {#await movies}
            <p>Movies are loading</p>
            {:then movies}
            {#each movies as movie}
                <p>{movie.name}</p>
            {/each}
        {/await}
    {/if}
</main>

<style type="text/scss">
</style>
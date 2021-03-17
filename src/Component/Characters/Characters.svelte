<script>
    import {onMount} from "svelte";

    let characters = []

    onMount(async function () {

        if (localStorage.getItem("characters")) {
            characters = JSON.parse(localStorage.getItem("characters"));
            console.log(characters[0])
            return;
        }

        const request = await fetch(`${__lotr.env.API_URL}/character`,{
            headers: {
                method: "GET",
                Authorization: `Bearer ${__lotr.env.API_TOKEN}`,
            },
        })
        .then(response => response.json())
        .then(data => {
            characters = data.docs;
            localStorage.setItem("characters", JSON.stringify(data.docs));
        });
    })
</script>

<main>
    <h1>Characters section</h1>
    {#if characters}
        {#await characters}
            <p>Is loading</p>
            {:then characters} 
            {#each characters as character }
                <p>{character.name}</p>
            {/each}
        {/await}
    {/if}
</main>

<style type="text/scss">
</style>
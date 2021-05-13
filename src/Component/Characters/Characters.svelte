<script>
    import {onMount} from "svelte";
    import SingleCharacter from "./SingleCharacter.svelte"
    let characters = []

    let race;
    let realm;

    onMount(async function () {

        if (localStorage.getItem("characters")) {
            characters = JSON.parse(localStorage.getItem("characters"));
            distinctArray(characters);
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

    const distinctArray = datas => {
        const raceArr = [];
        const realmArr = [];
        datas.map(d => {
            if (d.race.indexOf(",") > -1) {
                let dts = d.race.split(",");
                dts.map(el => {
                    !raceArr.includes(el) ? raceArr.push(el) : false;
                });                
            }else if (!raceArr.includes(d.race) && (d.race !== "NaN" && d.race.length > 0)) {
                raceArr.push(d.race);
            }
            
            if (d.realm.indexOf(",") > -1){
                let dts = d.realm.split(",");
                dts.map(el=>{
                    !realmArr.includes(el) ? realmArr.push(el) : false;
                });
            } else if (!realmArr.includes(d.realm) && (d.realm !== "NaN" && d.realm.length > 0)) {
                realmArr.push(d.realm);
            }
        });
        console.log(raceArr)
        console.log(realmArr)
    }
    
</script>

<main>
    <h1>Characters section</h1>
    
    {#if characters}
        {#await characters}
            <p>Is loading</p>
            {:then characters} 
            <div class="character-research">
                <select value={race} name="race">
                    {#each characters as character }
                        <option value={character.race}>
                            {character.race}
                        </option>
                    {/each}
                </select>
                <select value={realm} name="realm">
                    {#each characters as character }
                        <option value={character.realm}>
                            {character.realm}
                        </option>
                    {/each}
                </select>
            </div>
            <!-- <SingleCharacter character={character}/> -->
        {/await}
    {/if}
</main>

<style type="text/scss">
</style>
<script>
    import {onMount} from "svelte";
    import SingleCharacter from "./SingleCharacter.svelte"
    let datas = [];
    let clone = [];

    let raceAr = [];
    let realmAr = [];

    let race;
    let realm;

    onMount(async function () {

        if (localStorage.getItem("characters")) {
            datas = JSON.parse(localStorage.getItem("characters"));
            raceAr = distinctArray(datas).race;
            realmAr = distinctArray(datas).realm;
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
            datas = data.docs;
            localStorage.setItem("characters", JSON.stringify(data.docs));
        });

    });

    const distinctArray = datas => {
        let raceArr = [];
        let realmArr = [];
        datas.map(d => {
            if (!raceArr.includes(d.race) && (d.race !== "NaN" && d.race.length > 0)) {
                raceArr.push(d.race);
            }
            if (!realmArr.includes(d.realm) && (d.realm !== "NaN" && d.realm.length > 0)) {
                realmArr.push(d.realm);
            }
        });
        raceArr = sortDatas(raceArr);
        realmArr = sortDatas(realmArr);
        return {
            "race": raceArr,
            "realm": realmArr
        }
    }

    const sortDatas = (datas) => {
        datas.sort(function(a,b){
            if (a > b) {return 1}
            if (a < b) {return -1}
        });
        return datas;
    }

    const onSelectChange = _ => {
        let array = [];
        datas.map(el => {
            if (el.race === _.target.value) {
                array.push(el);
            }
            if (el.realm === _.target.value){
                array.push(el)
            }
        });
        console.log(array);
        return clone = array;
    }
    
</script>

<main>
    <h1>Characters section</h1>
    
    {#if datas}
        {#await datas}
            <p>Is loading</p>
            {:then datas} 
            <div class="character-research">
                <select value={race} name="race" on:change={onSelectChange.bind(race)}>
                    {#each raceAr as race}
                        <option value={race}>{race}</option>
                    {/each}
                </select>
                <select value={realm} name="realm"  on:change={onSelectChange.bind(realm)}>
                    {#each realmAr as realm}
                        <option value={realm}>{realm}</option>
                    {/each}
                </select>
            </div>

            {#each clone as character }
                <SingleCharacter character={character}/>
            {/each}
        {/await}
    {/if}
</main>

<style type="text/scss">
</style>
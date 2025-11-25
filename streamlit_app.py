import streamlit as st
import snowflake.snowpark as snowpark

def main(session: snowpark.Session):

    st.title("📈 Marketing ROI Intelligence Hub")

    # Load Gold table directly from Snowflake
    df = (
        session.table("MARKETING_ANALYTICS.DBT_VBHUMIREDDYGARI_ANALYTICS.MART_CHANNEL_DAILY_METRICS")
        .to_pandas()
    )

    # Filters
    st.subheader("Filters")
    platforms = st.multiselect(
        "Platform",
        df["PLATFORM"].unique().tolist(),
        default=df["PLATFORM"].unique().tolist()
    )

    channels = st.multiselect(
        "Channel",
        df["CHANNEL"].unique().tolist(),
        default=df["CHANNEL"].unique().tolist()
    )

    filtered = df[
        df["PLATFORM"].isin(platforms)
        & df["CHANNEL"].isin(channels)
    ]

    st.subheader("Summary")
    st.dataframe(filtered.head())

    st.subheader("ROAS Over Time")
    st.line_chart(filtered.groupby("DATE")["ROAS"].mean())

    # Budget Simulator
    st.subheader("Budget Simulator")
    pct = st.slider("Increase Spend (%)", -50, 100, 0)

    if pct != 0:
        factor = 1 + pct / 100
        filtered["SIM_COST"] = filtered["COST"] * factor
        filtered["SIM_REVENUE"] = filtered["REVENUE"] * factor
        st.metric(
            label="Simulated ROAS",
            value=round(filtered["SIM_REVENUE"].sum() / filtered["SIM_COST"].sum(), 2)
        )


# REQUIRED LINE FOR SNOWFLAKE STREAMLIT
import snowflake.snowpark as snowpark
session = snowpark.Session.builder.getOrCreate()
main(session)


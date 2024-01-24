import styled from 'styled-components';

export const Containers = styled.div`/*div태그를 만들겠다*/
    height: 100vh;
    display: grid;
    grid-template-areas:
    "header    header    header"
    "sidebar leftcontent rightcontent1"
    "sidebar leftcontent rightcontent2"
    "footer    footer    footer";
    grid-template-columns: 0.7fr 2fr 2fr;
    grid-template-rows: 1fr 2fr 2fr 1fr;
    `;
export const Header = styled.div`
    background-color: palevioletred;
    grid-area: header;
    `;

export const Sidebar = styled.div`
    background-color: lightgoldenrodyellow;
    grid-area: sidebar;
    `;

export const LeftContent = styled.div`
    background-color: cadetblue;
    grid-area: leftcontent;
    `;
export const RightContent1 = styled.div`
    background-color: lightsteelblue;
    grid-area: rightcontent1;
    overflow: auto;
    `;
export const RightContent2 = styled.div`
    background-color: coral;
    grid-area: rightcontent2;
    `
export const Footer = styled.div`
    background-color: olive;
    grid-area: footer;
    `


